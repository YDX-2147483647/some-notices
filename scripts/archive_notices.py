from argparse import ArgumentParser
from datetime import date, timedelta
from os import listdir
from os.path import join

from frontmatter import parse, load, dump


def get_outdated_notices(root: str, before: date) -> list[str]:
    """ Get outdated but active notices
    :returns: list of filepaths.
    """

    outdated: list[str] = []

    for filename in listdir(root):
        filepath = join(root, filename)
        with open(filepath, encoding='utf-8') as f:
            metadata, _ = parse(f.read())

        assert 'status' in metadata
        if metadata['status'] == 'active' and 'due' in metadata:
            due: date | int | float = metadata['due']
            if isinstance(due, date):
                pass
            else:
                last_update: date = max(metadata['updated_on'])
                assert isinstance(last_update, date)
                due = last_update + timedelta(days=due)

            if due < before:
                outdated.append(filepath)

    return outdated


def set_as_archived(filepath: str) -> None:
    post = load(filepath)
    post.metadata['status'] = 'archived'
    dump(post, filepath)


def prepare_parser() -> ArgumentParser:
    parser = ArgumentParser(
        description='Filter out outdated notices and archive them.')
    parser.add_argument(
        'root',
        type=str,
        help='The root folder of the notices.'
    )
    parser.add_argument(
        '--verbose',
        action='store_true'
    )

    return parser


if __name__ == '__main__':
    parser = prepare_parser()
    args = parser.parse_args()

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
        set_as_archived(notice)

    if args.verbose and outdated:
        print('✓ Done.')
