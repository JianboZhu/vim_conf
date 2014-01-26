// Author: Jianbo Zhu (zhujianbo@umeng.com)
//

#include <glog/logging.h>
#include "rapidjson/stringbuffer.h"
#include "rapidjson/writer.h"

#include <boost/unordered_map.hpp>

#include "base/basic_types.h"
#include "engine/dsp/ad_types/banner_ads/banner_ad_constructor.h"

using std::string;
using std::vector;

using rapidjson::Document;
using rapidjson::StringBuffer;
using rapidjson::Value;
using rapidjson::Writer;

using boost::unordered_map;

using namespace engine::dsp;


bool BuildAdResponse(
    const vector<string>& ordered_ad_ids,
    string* ad_response) {
  BannerAdConstructor* ad_constructor_ = new BannerAdConstructor();
  Document ad_response_in_doc;
  ad_response_in_doc.SetObject();
  Document::AllocatorType& allocator = ad_response_in_doc.GetAllocator();
  ad_constructor_->SetAllocator(&allocator);

  Value creatives;
  creatives.SetArray();

  vector<string>::const_iterator ad_id_iter = ordered_ad_ids.begin();
  for (; ad_id_iter != ordered_ad_ids.end(); ++ad_id_iter) {
    Value creative;
    creative.SetObject();

    unordered_map<string, string> attrs;
    attrs.insert(std::make_pair("url", "http://this_is_a_url/a/l?test=true"));

    ad_constructor_->ConstructAd(attrs, &creative);

    creatives.PushBack(creative, allocator);
  }

  // Set returned creative num.
  ad_response_in_doc.AddMember("count", creatives.Size(), allocator);

  ad_response_in_doc.AddMember("ads", creatives, allocator);

  StringBuffer buffer;
  Writer<StringBuffer> writer(buffer);
  ad_response_in_doc.Accept(writer);

  *ad_response = buffer.GetString();

  DLOG(INFO) << "## ad response json debug string: \n"
             << *ad_response;

  delete ad_constructor_;

  return true;
}

int main() {
  string ad_response;
  vector<string> ads;
  ads.push_back("123");
  ads.push_back("1234");
  ads.push_back("12345");

  BuildAdResponse(ads, &ad_response);
}
