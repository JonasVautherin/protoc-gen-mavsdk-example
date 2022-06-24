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

int main(int argc, char **argv) {
  testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}

