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
			When call ./join $2
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
			%text
			#|Usage: ./join [options...] [--] [patterns...] [--] [inputs...]
			#|
			#|Options:
			#|  -c,--copyright    Print copyright information.
			#|  -h,--help         Print this message.
			#|  -l,--lines NUM    Set the number of lines to be deleted at the beginning of
			#|                    each entry to NUM.
			#|  -v,--version      Print version information.
			#|
			#|Patterns are defined with the following syntax:
			#|  1. @<PATTERN>@=<file>
			#|  2. @<PATTERN>@=<directory>
			#|  3. @<PATTERN>@="<string>"
			#|
			#|PATTERN must be uppercase.
			#|
			#|With the syntax (1), all the entries @PATTERN@ in inputs will be replaced by the
			#|content of file.
			#|
			#|With the syntax (2), all the entries @PATTERN@ in inputs will be replaced by the
			#|content of all the files in directory.
			#|
			#|With the syntax (3), all the entries @PATTERN@ in inputs will be replaced by
			#|string. As the shell will probably interpreted double quotes, the latter should
			#|be escaped, e.g. @FOO@='"bar"'.
			#|
			#|./join Copyright (C) 2024 Mattéo Rossillol‑‑Laruelle <beatussum@protonmail.com>
			#|This program comes with ABSOLUTELY NO WARRANTY; for details type `./join --copyright'.
			#|This is free software, and you are welcome to redistribute it
			#|under certain conditions; type `./join --copyright' for details.
		}

		It "with $1"
			When call ./join $2
			The output should eq "$(result)"
			The status should be success
		End
	End
End
