from behave import *
import os
import yaml


@given(u'set of PPS files for single AVHRR GAC swath available')
def step_impl(context):

    assert cloudmask.data is not None
    assert sunsatangles.data is not None
    assert bt1.data is not None
    assert cloudtypes.data is not None
