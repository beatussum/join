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


Describe "actions"
	Describe '`copyright`'
		Parameters
			"short option" -c
			"long option" --copyright
		End

		result() {
			%text
			#|Copyright (C) 2024 Mattéo Rossillol‑‑Laruelle <beatussum@protonmail.com>
			#|
			#|This program is free software: you can redistribute it and/or modify
			#|it under the terms of the GNU General Public License as published by
			#|the Free Software Foundation, either version 3 of the License, or
			#|(at your option) any later version.
			#|
			#|This program is distributed in the hope that it will be useful,
			#|but WITHOUT ANY WARRANTY; without even the implied warranty of
			#|MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
			#|GNU General Public License for more details.
			#|
			#|You should have received a copy of the GNU General Public License
			#|along with this program.  If not, see <https://www.gnu.org/licenses/>.
		}

		It "with $1"
			When run source "${PWD}/join" $2
			The output should eq "$(result)"
			The status should be success
		End
	End

	Describe '`help`'
		Parameters
			"short option" -h
			"long option" --help
		End

		result() {
			@cat <<-EOF
			Usage: ${PWD}/join [options...] [--] [patterns...] [--] [inputs...]

			Options:
			  -c,--copyright    Print copyright information.
			  -h,--help         Print this message.
			  -l,--lines NUM    Set the number of lines to be deleted at the beginning of
			                    each entry to NUM.
			  -v,--version      Print version information.

			Patterns are defined with the following syntax:
			  1. @<PATTERN>@=<file>
			  2. @<PATTERN>@=<directory>
			  3. @<PATTERN>@="<string>"

			PATTERN must be uppercase.

			With the syntax (1), all the entries @PATTERN@ in inputs will be replaced by the
			content of file.

			With the syntax (2), all the entries @PATTERN@ in inputs will be replaced by the
			content of all the files in directory.

			With the syntax (3), all the entries @PATTERN@ in inputs will be replaced by
			string. As the shell will probably interpreted double quotes, the latter should
			be escaped, e.g. @FOO@='"bar"'.

			${PWD}/join Copyright (C) 2024 Mattéo Rossillol‑‑Laruelle <beatussum@protonmail.com>
			This program comes with ABSOLUTELY NO WARRANTY; for details type \`${PWD}/join --copyright'.
			This is free software, and you are welcome to redistribute it
			under certain conditions; type \`${PWD}/join --copyright' for details.
			EOF
		}

		It "with $1"
			When run source "${PWD}/join" $2
			The output should eq "$(result)"
			The status should be success
		End
	End

	Describe '`lines`'
		Parameters
			"short option" -l
			"long option" --lines
		End

		Describe "with $1"
			It "with not a number"
				result() {
					@cat <<EOF

===============================================================================
Fatal error with the following message:
  -> \`foo\` is not a number

${PWD}/join at line 229:

					die "\\\`\$2\\\` is not a number"

===============================================================================
EOF
				}

				When run source "${PWD}/join" $2 foo
				The error should eq "$(result)"
				The status should be failure
			End
		End
	End

	It "with not a correct option"
		result() {
			@cat <<EOF
Usage: ${PWD}/join [options...] [--] [patterns...] [--] [inputs...]

Options:
  -c,--copyright    Print copyright information.
  -h,--help         Print this message.
  -l,--lines NUM    Set the number of lines to be deleted at the beginning of
                    each entry to NUM.
  -v,--version      Print version information.

Patterns are defined with the following syntax:
  1. @<PATTERN>@=<file>
  2. @<PATTERN>@=<directory>
  3. @<PATTERN>@="<string>"

PATTERN must be uppercase.

With the syntax (1), all the entries @PATTERN@ in inputs will be replaced by the
content of file.

With the syntax (2), all the entries @PATTERN@ in inputs will be replaced by the
content of all the files in directory.

With the syntax (3), all the entries @PATTERN@ in inputs will be replaced by
string. As the shell will probably interpreted double quotes, the latter should
be escaped, e.g. @FOO@='"bar"'.

${PWD}/join Copyright (C) 2024 Mattéo Rossillol‑‑Laruelle <beatussum@protonmail.com>
This program comes with ABSOLUTELY NO WARRANTY; for details type \`${PWD}/join --copyright'.
This is free software, and you are welcome to redistribute it
under certain conditions; type \`${PWD}/join --copyright' for details.

===============================================================================
Fatal error with the following message:
  -> \`--foo\` is not a correct option

${PWD}/join at line 250:

				die "\\\`\$1\\\` is not a correct option"

===============================================================================
EOF
		}

		When run source "${PWD}/join" --foo
		The error should eq "$(result)"
		The status should be failure
	End

	It "normal usage"
		BeforeRun setup
		AfterRun cleanup

		result() {
			@cat <<-EOF
			This file is a test template.

			foo@bar.com && bar@foo.org

			Hello world!

			EOF

			for _ in {1..10}; do
				echo
			done

			for _ in {1..5}; do
				print_content
				echo
			done

			%text
			#|The string `Lorem ipsum dolor sit amet, consectetur adipiscing elit.
			#|Proin rutrum tincidunt enim eu rutrum.
			#|Pellentesque pellentesque vestibulum leo tempus porta.
			#|Cras ultrices consectetur massa, vel imperdiet eros hendrerit vitae.
			#|Maecenas molestie urna in dui ultricies laoreet.
			#|Duis luctus erat vel tortor vehicula rhoncus.
			#|Curabitur id tincidunt arcu, et malesuada ante.
			#|Ut ac accumsan erat.
			#|Nam eu risus placerat ante suscipit volutpat et sed orci.
			#|Nunc eget varius lectus.
			#|In ullamcorper aliquet ex, at vestibulum lectus mollis in.
			#|Duis pulvinar viverra sem, et ultrices eros placerat vitae.
			#|Proin neque sapien, placerat ut sem vitae, iaculis luctus sem.` is a lorem ipsum.
		}

		When run source "${PWD}/join" \
			--lines 0 \
			-- \
			HW='"Hello world!"' \
			FULLD="${TEST_DIR}/full.d" \
			FULL="${TEST_DIR}/full.d/full_1.txt" \
			-- \
			"${TEST_DIR}/template"

		The output should eq "$(result)"
		The status should be success
	End
End
