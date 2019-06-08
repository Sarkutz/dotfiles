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
