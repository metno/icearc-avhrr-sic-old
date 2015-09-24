Feature: Compute Sea Ice Concentration from GAC AVHRR records

    @wip
    Scenario: Convert single swath GAC record to sea ice concentration
        Given set of PPS files for single AVHRR GAC swath available
        When sea ice concentration processing applied
        Then all the PPS files are resampled to the 4k NSIDC Arctic stereographic grid
        Then sea ice surface PPS pixels are aggregated to 50 km NSIDC grid
        Then data is saved as netcdf file
