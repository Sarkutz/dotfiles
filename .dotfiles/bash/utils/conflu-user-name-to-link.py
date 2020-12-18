import sys

'''
conflu-user-name-to-link.py
Replace occurances of specified user names in stdin with the corresponding
user link and print the result (to stdout).
Usage example:
cat test.conf | python conflu-user-name-to-link.py | less
'''

user = {
	'user.name': 'user.id'
}


def get_user_link(user_name):
    user_id = user[user_name]
    user_link = '<ac:link><ri:user ri:userkey="{user_id}"/></ac:link>'.format(
            user_id=user_id)
    return user_link


def main():
    text = sys.stdin.read()
    for user_name in user:
        text = text.replace(user_name, get_user_link(user_name))
    print(text)


main()

