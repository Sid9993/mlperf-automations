from mlc import utils
import os


def preprocess(i):

    os_info = i['os_info']

    env = i['env']

    automation = i['automation']

    recursion_spaces = i['recursion_spaces']
    env['MLC_GET_DEPENDENT_CACHED_PATH'] = os.getcwd()

    return {'return': 0}
