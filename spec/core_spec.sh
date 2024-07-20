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


Describe "core"
	Include "${PWD}/join"

	Describe '`die()`'
		Describe "wihtout message"
			result() {
				@cat << EOF

===============================================================================
Fatal error with the following message:
  -> (none)

${PWD}/join at line 158:

	}

===============================================================================

EOF
			}

			It
				When run die
				The error should eq "$(result)"
				The status should be failure
			End
		End

		Describe "with message"
			result() {
				@cat << EOF

===============================================================================
Fatal error with the following message:
  -> Lorem ipsum

${PWD}/join at line 158:

	}

===============================================================================

EOF
			}

			It
				When run die "Lorem ipsum"
				The error should eq "$(result)"
				The status should be failure
			End
		End
	End

	Describe '`is_number()`'
		It "with an empty input"
			When call is_number ""
			The status should be failure
		End

		It "with a bad input"
			When call is_number "foo"
			The status should be failure
		End

		Describe "with a number"
			Parameters
				0
				1234
				+1234
				-1234
			End

			It
				When call is_number $1
				The status should be success
			End
		End
	End
End
