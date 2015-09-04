from behave import *
import os
import yaml
from pypps_reader import NwcSafPpsData
import numpy

@given(u'the project deployed using Ansible')
def step_impl(context):
    # check there is an Ansible directory
    assert context.ansible_basedir
    assert context.playbook_path


@then(u'there should be a playbook sitting in the Ansible directory')
def step_impl(context):
    # Check there is a readable playbook in the Ansible directory
    assert context.playbook[0]['vars']['local_gac_dir']


@when(u'data storage is avaiable')
def step_impl(context):
    assert context.ansible_basedir
    assert context.playbook
    context.data_dir = context.playbook[0]['vars']['local_gac_dir']
    assert os.path.exists(context.data_dir)


@then(u'it contains NOAA GAC satellite data')
def step_impl(context):
    year = "2008"
    date = "20080710"
    data_dir = os.path.join(context.data_dir, year, date)
    assert os.path.exists(data_dir)
    context.data_dir = data_dir

    # list data directory contents and check whether it contains all
    # necessary information
    file_list = os.listdir(data_dir)
    assert file_list is not None

    angles = filter(lambda x: 'sunsatangles' in x, file_list)
    cloudtypes = filter(lambda x: 'cloudtype' in x, file_list)
    avhrr = filter(lambda x: 'avhrr' in x, file_list)
    cloudmask = filter(lambda x: 'cloudmask' in x, file_list)

    context.avhrr_file_list = avhrr

    assert all([angles, cloudmask, cloudtypes, avhrr])


@then(u'the AVHRR data can be read using pypps_reader')
def step_impl(context):

    avhrr_data_file = os.path.join(context.data_dir, context.avhrr_file_list[0])
    avhrr_data_ch1 = NwcSafPpsData(avhrr_data_file).image1.data
    assert isinstance(avhrr_data_ch1, numpy.ndarray)
