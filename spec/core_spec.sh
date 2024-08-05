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
	Include ./join

	Describe '`die()`'
		It "wihtout message"
			When run die
			The line 1 of error should be blank
			The line 2 of error should eq "==============================================================================="
			The line 3 of error should eq "Fatal error with the following message:"
			The line 4 of error should eq "  -> (none)"
			The line 5 of error should be blank
			The line 7 of error should be blank
			The line 9 of error should be blank
			The line 10 of error should eq "==============================================================================="
			The line 11 of error should be blank
			The status should be failure
		End

		It "with message"
			When run die "Lorem ipsum"
			The line 1 of error should be blank
			The line 2 of error should eq "==============================================================================="
			The line 3 of error should eq "Fatal error with the following message:"
			The line 4 of error should eq "  -> Lorem ipsum"
			The line 5 of error should be blank
			The line 7 of error should be blank
			The line 9 of error should be blank
			The line 10 of error should eq "==============================================================================="
			The line 11 of error should be blank
			The status should be failure
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
