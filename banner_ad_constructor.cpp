// Author: Jianbo Zhu (zhujianbo@umeng.com)
//

#include "engine/dsp/ad_types/banner_ads/banner_ad_constructor.h"
#include <iostream>
#include <cstring>

#include <boost/assign.hpp>
#include <glog/logging.h>

#include "base/auto.h"

using namespace std;

using boost::assign::map_list_of;
using boost::unordered_map;
using rapidjson::Document;
using rapidjson::Value;

namespace engine {
namespace dsp {

namespace {

void TransformUrl(string* url) {
  url->assign("a_transformed_url");
  return;
}

inline void AddAttribute(
    const unordered_map<string, string>& ad_creative_attributes,
    const string& searching_name,
    const char* json_value_name,
    Document::AllocatorType* allocator,
    Value* ad_creative) {
  auto_t(pos, ad_creative_attributes.find(searching_name));
  if (pos != ad_creative_attributes.end()) {
    ad_creative->AddMember(json_value_name,
                           pos->second.c_str(),
                           *allocator);
  }
}

const unordered_map<string, int> display_type_mapping =
  map_list_of("standard", 0)
             ("image", 1)
             ("text", 2);

}  // Anonymous namespace


BannerAdConstructor::BannerAdConstructor() {
}

BannerAdConstructor::~BannerAdConstructor() {
}

void BannerAdConstructor::ConstructAd(
    const map_str_str_t& ad_creative_attributes,
    Value* ad_creative) {
  // There is a json response example:

  // Set icon
  AddAttribute(ad_creative_attributes,
               "icon",
               "icon",
               allocator_,
               ad_creative);

  // Set apk_name
  AddAttribute(ad_creative_attributes,
               "app_name", // FIXME(zhujianbo): is this right?
               "apk_name",
               allocator_,
               ad_creative);

  // Set package name
  AddAttribute(ad_creative_attributes,
               "package_name",
               "packagename",
               allocator_,
               ad_creative);

  // Set click url
  string url;
  auto_t(url_pos, ad_creative_attributes.find("url"));
  if (url_pos != ad_creative_attributes.end()) {
    url.assign(url_pos->second);
    cout  << "original url: " << url << endl;

    TransformUrl(&url);

    cout << "transformed url: " << url << endl;
    if (url.compare(url_pos->second) == 0) {
      cout << "## equals" << endl;
    }

    ad_creative->AddMember("click_url",
                           url.c_str(),
                           *allocator_);
  }

  // Set title
  AddAttribute(ad_creative_attributes,
               "title",
               "title",
               allocator_,
               ad_creative);

  // Set sub_title1
  // TODO(zhu): is this right?
  AddAttribute(ad_creative_attributes,
               "ad_desc",
               "sub_title1",
               allocator_,
               ad_creative);
  // Set banner_img
  AddAttribute(ad_creative_attributes,
               "ad_pic",
               "banner_img",
               allocator_,
               ad_creative);

  // Set apk
  ad_creative->AddMember("apk", "", *allocator_);
  // TODO(zhujianbo): Is this right?
  AddAttribute(ad_creative_attributes,
               "apk_size",
               "apk",
               allocator_,
               ad_creative);

  // Set category
  ad_creative->AddMember("category", "2", *allocator_);

  // Set app_open
  ad_creative->AddMember("app_open", "", *allocator_);

  // Set action
  ad_creative->AddMember("action", 0, *allocator_);

  // Set filter_notice
  // FIXME(zhu):
  ad_creative->AddMember("filter_notice", "0", *allocator_);

  // Set display type
  // Mapping rules: "standard"(0), "image"(1), "text"(2)
  auto_t(display_type_pos, ad_creative_attributes.find("display_type"));
  if (display_type_pos != ad_creative_attributes.end()) {
    auto_t(mapping_pos, display_type_mapping.find(display_type_pos->second));
    if (mapping_pos != display_type_mapping.end()) {

      ad_creative->AddMember("type",
                             mapping_pos->second,
                             *allocator_);
    }
  }

  // Set cost_per
  ad_creative->AddMember("cost_per", "cpc", *allocator_);

  // Set filter_open
  ad_creative->AddMember("filter_open", "0", *allocator_);
}

}  // namespace dsp
}  // namespace engine
