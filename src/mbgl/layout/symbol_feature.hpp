#pragma once

#include <mbgl/tile/geometry_tile_data.hpp>
#include <mbgl/util/optional.hpp>

#include <string>

namespace mbgl {

class SymbolFeature {
public:
    GeometryCollection geometry;
    optional<std::u16string> text;
    optional<std::string> icon;
    float iconRotation;
    std::size_t index;
};

} // namespace mbgl
