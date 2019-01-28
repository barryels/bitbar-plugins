#!./../../test/libs/bats/bin/bats

load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'

@test "Should return the correct ordinal" {
    # assert_equal $(echo 1+1 | bc) 2
    assert_equal $(echo ./ordinal-from-number.sh | bc) "st"
}