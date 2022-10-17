from argparse import ArgumentParser
from datetime import date, timedelta
from pathlib import Path

from frontmatter import dump, load, parse


def get_outdated_notices(root: Path, before: date) -> list[Path]:
    """ Get outdated but active notices
    :returns: list of filepaths.
    """

    outdated: list[Path] = []

    for filepath in root.glob('*.md'):
        with filepath.open(mode='r', encoding='utf-8') as f:
            metadata, _ = parse(f.read())

        assert 'status' in metadata, f'No `status` in “{filepath}”.'
        if metadata['status'] == 'active' and 'due' in metadata:
            due: date | int | float = metadata['due']
            assert isinstance(due, date | int | float), \
                f'Cannot parse `due`: “{due}” in “{filepath}”.'

            # Unify `due` to a `date`
            if isinstance(due, date):
                pass
            else:
                last_update: date = max(metadata['updated_on'])
                assert isinstance(last_update, date),\
                    f'The item in `updated_on` is not a date: “{last_update}” in “{filepath}”.'
                due = last_update + timedelta(days=due)

            if due < before:
                outdated.append(filepath)

    return outdated


def set_as_archived(filepath: Path) -> None:
    post = load(filepath)
    post.metadata['status'] = 'archived'
    dump(post, filepath)


def build_parser() -> ArgumentParser:
    parser = ArgumentParser(
        description='Filter out outdated notices and archive them.')
    parser.add_argument(
        'root',
        type=Path,
        help='The root folder of the notices.'
    )
    parser.add_argument(
        '--verbose',
        action='store_true'
    )
    parser.add_argument(
        '--dry-run',
        action='store_true'
    )

    return parser


if __name__ == '__main__':
    args = build_parser().parse_args()

    outdated = get_outdated_notices(args.root, date.today())

    if args.verbose:
        if outdated:
            print(f'Found {len(outdated)} outdated notice(s).')
            print('Archiving …')
        else:
            print("There's nothing outdated. :-)")

    for notice in outdated:
        if args.verbose:
            print(f"  - {notice}")
        if not args.dry_run:
            set_as_archived(notice)

    if args.verbose and outdated:
        print('✓ Done.')

    if args.dry_run:
        print('—— Dry run. (nothing changed)')
