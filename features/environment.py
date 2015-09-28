from behave import *
import yaml
import os
import dateutil

def before_all(context):
    context.ansible_basedir = os.path.join(os.path.curdir, 'ansible')
    context.playbook_path = os.path.join(context.ansible_basedir, 'playbook.yml')
    with open(context.playbook_path) as playbook:
        playbook = playbook.read()
    context.playbook = yaml.safe_load(playbook)
    context.test_date_string = context.playbook[0]['vars']['test_date']
    context.local_avhrr_dir = context.playbook[0]['vars']['local_gac_dir']
    context.local_nsidc_dir = context.playbook[0]['vars']['local_sic_dir']

    context.test_date = dateutil.parser.parse(context.test_date_string)
