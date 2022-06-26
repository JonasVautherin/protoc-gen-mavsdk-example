#include <gtest/gtest.h>

#include "some_api.h"

TEST(Poke, JustRunPoke) {
    SomeApi some_api;
    some_api.poke();
}

TEST(Echo, EchoesTheSentValue) {
    SomeApi some_api;
    auto echo_value = some_api.echo("blah");
    ASSERT_EQ("blah", echo_value);
}

TEST(Add, AddsIntegersCorrectly) {
    SomeApi some_api;
    SomeApi::TwoIntegers two_integers{3, 4};

    auto sum = some_api.add(two_integers);

    ASSERT_EQ(7, sum);
}

int main(int argc, char **argv) {
  testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}

