from behave import *
import os
import yaml
import glob
from pypps_reader import NwcSafPpsData

@given(u'set of PPS files for single AVHRR GAC swath available')
def step_impl(context):

    # define date, get it from the playbook
    # identify where the storage is, get it from the playbook
    # load four parameters for a given date

    def get_filelist(data_dir, some_pattern):
        unsorted_list = glob.glob(os.path.join(data_dir, '*' + some_pattern + '*'))
        sorted_list = sorted(unsorted_list)
        return sorted_list

    data_dir = os.path.join(context.local_gac_dir,
                            str(context.test_date.year),
                            context.test_date_string)

    avhrr_filepath = get_filelist(data_dir, 'avhrr')[0]
    angles_filepath = get_filelist(data_dir, 'sunsatangles')[0]
    cloudmask_filepath = get_filelist(data_dir, 'cloudmask')[0]
    cloudtype_filepath = get_filelist(data_dir, 'cloudtype')[0]

    avhrr = NwcSafPpsData(avhrr_filepath)
    bt1 = avhrr.image1

    angles = NwcSafPpsData(angles_filepath)
    cloudmask= NwcSafPpsData(cloudmask_filepath)
    cloudtype = NwcSafPpsData(cloudtype_filepath)

    assert cloudmask.data is not None
    assert angles.data is not None
    assert bt1.data is not None
    assert cloudtype.data is not None
