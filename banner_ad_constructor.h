// Author: Jianbo Zhu (zhujianbo@umeng.com)
//
// 'BannerAdConstructor', as its name, is only applying to 'banner ads'.

#ifndef ENGINE_DSP_AD_TYPES_BANNER_ADS_BANNER_AD_CONSTRUCTOR_H_
#define ENGINE_DSP_AD_TYPES_BANNER_ADS_BANNER_AD_CONSTRUCTOR_H_

#include <boost/scoped_ptr.hpp>
#include <boost/unordered_map.hpp>
#include "rapidjson/document.h"

namespace engine {
namespace dsp {

typedef boost::unordered_map<std::string, std::string> map_str_str_t;

class BannerAdConstructor {
 public:
  BannerAdConstructor();

  virtual ~BannerAdConstructor();

  inline void SetAllocator(rapidjson::Document::AllocatorType* allocator) {
    allocator_ = allocator;
  }

  void ConstructAd(
      const map_str_str_t& ad_creative_attributes,
      rapidjson::Value* ad_creative);

  rapidjson::Document::AllocatorType* allocator_;
};


}  // namespace dsp
}  // namespace engine

#endif  // ENGINE_DSP_AD_TYPES_BANNER_ADS_BANNER_AD_CONSTRUCTOR_H_
