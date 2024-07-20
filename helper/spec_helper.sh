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
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin rutrum tincidunt enim eu rutrum. Pellentesque pellentesque vestibulum leo tempus porta. Cras ultrices consectetur massa, vel imperdiet eros hendrerit vitae. Maecenas molestie urna in dui ultricies laoreet. Duis luctus erat vel tortor vehicula rhoncus. Curabitur id tincidunt arcu, et malesuada ante. Ut ac accumsan erat. Nam eu risus placerat ante suscipit volutpat et sed orci. Nunc eget varius lectus. In ullamcorper aliquet ex, at vestibulum lectus mollis in. Duis pulvinar viverra sem, et ultrices eros placerat vitae. Proin neque sapien, placerat ut sem vitae, iaculis luctus sem.

	Duis porttitor ipsum hendrerit consequat interdum. Sed sodales facilisis tortor, et convallis massa gravida sed. Duis rutrum porttitor mauris quis lacinia. Duis id dolor nunc. Fusce tristique, neque vitae feugiat mollis, mi massa finibus magna, et efficitur lorem leo nec magna. Proin laoreet nibh eleifend porta hendrerit. Phasellus sed tincidunt arcu. Sed facilisis est sit amet velit luctus dictum. Praesent suscipit ut diam sit amet accumsan.

	Aliquam ut feugiat elit, eu ullamcorper metus. Sed blandit lacus id quam porta mattis. Suspendisse non eleifend ante. Nunc vehicula augue vel purus feugiat, a condimentum risus mollis. Integer a orci ipsum. Etiam ac bibendum libero. Phasellus a tellus pulvinar purus mattis egestas eget id nisl. Donec molestie sagittis mauris vel vulputate. Quisque non dolor vestibulum, placerat mi eget, consequat nulla. Quisque sem lacus, fermentum vel dui et, lobortis vehicula nisi. Quisque sit amet elit tincidunt, mollis lorem a, cursus dolor. Cras ut orci in mauris elementum accumsan. Cras venenatis dignissim arcu, non tristique felis tempor eget.

	Proin auctor justo vitae dapibus faucibus. Phasellus posuere libero augue, eu sollicitudin leo iaculis non. Maecenas nibh ligula, euismod eget ex ut, tristique rutrum eros. Sed congue vitae sem vitae vulputate. Integer iaculis sem sit amet libero faucibus, rhoncus feugiat lacus efficitur. Fusce a arcu sit amet turpis feugiat egestas. Nam tincidunt nisl sit amet nulla suscipit varius. Sed viverra consequat condimentum. Cras nisi elit, ultricies quis tincidunt non, egestas sagittis ipsum. Nullam pulvinar, tellus vitae dictum condimentum, leo turpis hendrerit nisl, in consectetur odio est id eros.

	Proin feugiat vestibulum efficitur. Ut in orci a ante efficitur suscipit feugiat dignissim est. Donec diam nulla, pellentesque at leo ac, tempor cursus turpis. Morbi pharetra scelerisque massa vel euismod. In hac habitasse platea dictumst. Duis quis suscipit sapien. Sed ultrices nulla id tellus convallis rutrum. Sed vel nunc tellus. Vivamus quis mi et massa efficitur interdum ac a augue.
	EOF
}

create_file() {
	local file="$1"; shift
	local content="$*"

	@cat <<< "${content}" > "${file}"
}

# hooks #

setup() {
	@mkdir -p "${TEST_DIR}"/{empty,full}.d

	for i in {1..20}; do
		create_file "${TEST_DIR}/full.d/empty_${i}.txt"
		create_file "${TEST_DIR}/full.d/full_${i}.txt" "$(print_content)"
	done
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
