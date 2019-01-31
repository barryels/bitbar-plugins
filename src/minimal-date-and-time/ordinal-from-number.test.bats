#!./../../test/libs/bats/bin/bats

load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'

@test "Should return the correct ordinal" {
    actual="$(./ordinal-from-number.sh 1)"
    assert_equal "$actual" "st"

    actual="$(./ordinal-from-number.sh 2)"
    assert_equal "$actual" "nd"

    actual="$(./ordinal-from-number.sh 3)"
    assert_equal "$actual" "rd"

    actual="$(./ordinal-from-number.sh 4)"
    assert_equal "$actual" "th"

    actual="$(./ordinal-from-number.sh 11)"
    assert_equal "$actual" "th"

    actual="$(./ordinal-from-number.sh 21)"
    assert_equal "$actual" "st"

    actual="$(./ordinal-from-number.sh 22)"
    assert_equal "$actual" "nd"

    actual="$(./ordinal-from-number.sh 23)"
    assert_equal "$actual" "rd"

    actual="$(./ordinal-from-number.sh 24)"
    assert_equal "$actual" "th"
}
