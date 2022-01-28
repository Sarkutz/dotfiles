#!/usr/bin/env python

def remove_token(text, token, sep):
    """
    remove_token
    ------------
    From a ``text`` string consisting of multiple tokens separated by ``sep`` character, remove ``token`` from the list.
    EXAMPLE: remove_token('a:b:c:b:d', 'b', ':')
    """

    tokens = text.split(sep)
    selected_tokens = filter(lambda x: x != token, tokens)
    final_text = ":".join(selected_tokens)
    return final_text


def matrix_send(password, message):
    '''
    matrix_send
    -----------
    '''
    import asyncio
    from nio import AsyncClient

    async def send_message_private(password, message):
        client = AsyncClient("https://matrix-client.matrix.org",
                "@ashim.ghosh.bot:matrix.org")
        print(await client.login(password, "matrix-nio-one-shot"))

        await client.room_send(
                # Watch out! If you join an old room you'll see lots of old messages
                room_id="!wBqCQoVeBlQxmxwMID:matrix.org",
                message_type="m.room.message",
                content = {
                    "msgtype": "m.text",
                    "body": message
                    }
                )

        await client.logout()
        await client.close()

    asyncio.get_event_loop().run_until_complete(
            send_message_private(password, message))

