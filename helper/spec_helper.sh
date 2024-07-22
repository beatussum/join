# Copyright (C) 2024 Mattéo Rossillol‑‑Laruelle <beatussum@protonmail.com>
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.


#########
# HOOKS #
#########

# variables #

readonly TEST_DIR="${PWD}/test"

# helpers #

print_content() {
	@cat <<- EOF
	Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Proin rutrum tincidunt enim eu rutrum.
	Pellentesque pellentesque vestibulum leo tempus porta.
	Cras ultrices consectetur massa, vel imperdiet eros hendrerit vitae.
	Maecenas molestie urna in dui ultricies laoreet.
	Duis luctus erat vel tortor vehicula rhoncus.
	Curabitur id tincidunt arcu, et malesuada ante.
	Ut ac accumsan erat.
	Nam eu risus placerat ante suscipit volutpat et sed orci.
	Nunc eget varius lectus.
	In ullamcorper aliquet ex, at vestibulum lectus mollis in.
	Duis pulvinar viverra sem, et ultrices eros placerat vitae.
	Proin neque sapien, placerat ut sem vitae, iaculis luctus sem.
	EOF
}

create_file() {
	local file="$1"; shift
	local content="$*"

	@cat <<< "${content}" > "${file}"
}

# hooks #

set_options() {
	JOIN_OPTIONS[lines]=0
}

setup() {
	@mkdir -p "${TEST_DIR}"/{empty,full}.d

	for i in {1..5}; do
		create_file "${TEST_DIR}/full.d/empty_${i}.txt"
		create_file "${TEST_DIR}/full.d/full_${i}.txt" "$(print_content)"
	done

	cat <<- "EOF" > "${TEST_DIR}/template"
	This file is a test template.

	foo@bar.com && bar@foo.org

	@HW@

	@FULLD@

	The string `@FULL@` is a lorem ipsum.
	EOF
}

cleanup() {
	@rm -r "${TEST_DIR}"
}

####################
# MODULE FUNCTIONS #
####################

spec_helper_precheck() {
	minimum_version "0.28.1"
}

spec_helper_loaded() {
	:
}

spec_helper_configure() {
	:
}
