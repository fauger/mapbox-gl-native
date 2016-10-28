#pragma once

#include <mbgl/util/variant.hpp>
#include <mbgl/style/undefined.hpp>
#include <mbgl/style/function/camera_function.hpp>
#include <mbgl/style/function/source_function.hpp>
#include <mbgl/style/function/composite_function.hpp>

namespace mbgl {
namespace style {

template <class T>
class DataDrivenPropertyValue {
private:
    using Value = variant<
        Undefined,
        T,
        CameraFunction<T>,
        SourceFunction<T>,
        CompositeFunction<T>>;

    Value value;

    friend bool operator==(const DataDrivenPropertyValue& lhs,
                           const DataDrivenPropertyValue& rhs) {
        return lhs.value == rhs.value;
    }

public:
    DataDrivenPropertyValue() = default;
    DataDrivenPropertyValue(                  T  v) : value(std::move(v)) {}
    DataDrivenPropertyValue(   CameraFunction<T> v) : value(std::move(v)) {}
    DataDrivenPropertyValue(   SourceFunction<T> v) : value(std::move(v)) {}
    DataDrivenPropertyValue(CompositeFunction<T> v) : value(std::move(v)) {}

    bool isUndefined() const { return value.template is<Undefined>(); }

    template <typename Evaluator>
    auto evaluate(const Evaluator& evaluator) const {
        return Value::visit(value, evaluator);
    }
};

} // namespace style
} // namespace mbgl
