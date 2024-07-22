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


Describe "helpers"
	Include "${PWD}/join"

	BeforeEach setup
	AfterEach cleanup

	BeforeAll set_options

	Describe '`accumulate()`'
		Describe "with a directory"
			It "without file"
				result() {
					@cat <<EOF

===============================================================================
Fatal error with the following message:
  -> (none)

${PWD}/join at line 73:

	[[ -n "\${ret}" ]] || die

===============================================================================

EOF
				}

				When run accumulate "${TEST_DIR}/empty.d"
				The error should eq "$(result)"
				The status should be failure
			End

			It "with files"
				result() {
					for _ in {1..10}; do
						echo
					done

					for _ in {1..5}; do
						print_content
						echo
					done
				}

				When call accumulate "${TEST_DIR}/full.d"
				The output should eq "$(result)"
				The status should be success
			End
		End

		It "with a file"
			When call accumulate "${TEST_DIR}/full.d/full_1.txt"
			The output should eq "$(print_content)"
			The status should be success
		End
	End

	It '`get_content_of()`'
		When call get_content_of "${TEST_DIR}/full.d/full_1.txt"
		The output should eq "$(print_content)"
		The status should be success
	End

	Describe '`list()`'
		Describe "with directory"
			It "without file"
				When call list "${TEST_DIR}/empty.d"
				The output should be blank
				The status should be success
			End

			It "with files"
				result() {
					for i in {1..5}; do
						echo "${TEST_DIR}/full.d/empty_${i}.txt"
					done

					for i in {1..5}; do
						echo "${TEST_DIR}/full.d/full_${i}.txt"
					done
				}

				When call list "${TEST_DIR}/full.d"
				The output should eq "$(result)"
				The status should be success
			End
		End

		It "with pipe"
			When call list /dev/stdout
			The output should eq /dev/stdout
			The status should be success
		End

		It "with file"
			When call list "${TEST_DIR}/full.d/empty_1.txt"
			The output should eq "${TEST_DIR}/full.d/empty_1.txt"
			The status should be success
		End

		It "with bad entry"
			result() {
				@cat <<EOF

===============================================================================
Fatal error with the following message:
  -> \`\` does not exist

${PWD}/join at line 97:

		die "\\\`\${entry}\\\` does not exist"

===============================================================================

EOF
			}

			When run list
			The error should eq "$(result)"
			The status should be failure
		End
	End
End
