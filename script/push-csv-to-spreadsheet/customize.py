from mlc import utils
import os


def preprocess(i):

    os_info = i['os_info']
    env = i['env']
    meta = i['meta']
    automation = i['automation']

    return {'return': 0}


def postprocess(i):
    return {'return': 0}
