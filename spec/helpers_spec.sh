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
	End

	Describe '`get_content_of()`'
		result() {
			%text
			#|Maecenas molestie urna in dui ultricies laoreet.
			#|Duis luctus erat vel tortor vehicula rhoncus.
			#|Curabitur id tincidunt arcu, et malesuada ante.
			#|Ut ac accumsan erat.
			#|Nam eu risus placerat ante suscipit volutpat et sed orci.
			#|Nunc eget varius lectus.
			#|In ullamcorper aliquet ex, at vestibulum lectus mollis in.
			#|Duis pulvinar viverra sem, et ultrices eros placerat vitae.
			#|Proin neque sapien, placerat ut sem vitae, iaculis luctus sem.
		}

		It
			When call get_content_of "${TEST_DIR}/full.d/full_1.txt"
			The output should eq "$(result)"
			The status should be success
		End
	End

	Describe '`list()`'
		Describe "with directory"
			It "without file"
				When call list "${TEST_DIR}/empty.d"
				The output should be blank
				The status should be success
			End

			Describe "with files"
				result() {
					for i in {1..20}; do
						echo "${TEST_DIR}/full.d/empty_${i}.txt"
						echo "${TEST_DIR}/full.d/full_${i}.txt"
					done
				}

				It
					When call list "${TEST_DIR}/full.d"
					The output should eq "$(result)"
					The status should be success
				End
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

		Describe "with bad entry"
			result() {
				@cat << EOF

===============================================================================
Fatal error with the following message:
  -> \`\` does not exist

${PWD}/join at line 93:

		die "\\\`\${entry}\\\` does not exist"

===============================================================================

EOF
			}

			It
				When run list
				The error should eq "$(result)"
				The status should be failure
			End
		End
	End
End
