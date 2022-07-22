from cmind import utils
import os

def preprocess(i):

    os_info = i['os_info']

    env = i['env']

    recursion_spaces = i['recursion_spaces']

    r = i['automation'].detect_version_using_script({
               'env': env,
               'run_script_input':i['run_script_input'],
               'recursion_spaces':recursion_spaces})
    if r['return'] >0:
       if r['return'] == 16:
           if env.get('CM_TMP_FAIL_IF_NOT_FOUND','').lower() == 'yes':
               return r

           print (recursion_spaces+'    # {}'.format(r['error']))
 
           install_tags="install,tensorflow,python-lib"
           if env["CM_HOST_PLATFORM_FLAVOR"] == "arm64":
               install_tags="install,tensorflow-aarch64,python-lib"

           # Attempt to run installer
           r = {'return':0, 'skip':True, 'script':{'tags':install_tags}}

       return r

    return {'return':0}


def postprocess(i):

    env = i['env']

    r = i['automation'].parse_version({'match_text': r'\s*([\d.a-z\-]+)',
                                       'group_number': 1,
                                       'env_key':'CM_TENSORFLOW_VERSION',
                                       'which_env':i['env']})
    if r['return'] >0: return r

    version = r['version']

    print (i['recursion_spaces'] + '      Detected version: {}'.format(version))

    env['CM_TENSORFLOW_CACHE_TAGS'] = 'version-'+version

    return {'return':0, 'version':version}
