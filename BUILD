# Author: Jianbo Zhu (zhujianbo@umeng.com)
#
# Blade build file for 'banner ads'.

cc_library(
  name = 'banner_ad_constructor',
  srcs = 'banner_ad_constructor.cpp',
  deps = [
  ]
)

cc_binary(
    name = 'main',
    srcs = 'main.cpp',
    deps = [
      ':banner_ad_constructor',
      '#glog',
    ],
)


cc_library(
  name = 'banner_ads_show_impl',
  srcs = 'banner_ads_show_impl.cpp',
  deps = [
    '//engine/data/provider:adgroup_data_provider',
    '//engine/dsp:show_impl',
    #'//engine/dsp/filter:ad_creatives_filter',
    #'//engine/dsp/filter:area_filter',
    #'//engine/dsp/filter:platform_filter',
    #'//engine/dsp/filter:time_range_filter',
    #'//engine/dsp/filter:view_type_filter',
  ]
)
