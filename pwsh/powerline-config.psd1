
@{
    EscapeSequences = @{
      Esc = '['
      Store = '[s'
      Recall = '[u'
      Clear = '[0m'
    }
    PowerLineConfig = @{
      HideErrors = $True
      Colors = @((RgbColor 'Blue'),(RgbColor 'DarkBlue'),(RgbColor 'DarkBlue'),(RgbColor 'Blue'))
      Prompt = @(
          (ScriptBlock ' New-PromptText -Bg "#196DFF" -ElevatedBackgroundColor "#FF5D00" -Fg White $MyInvocation.HistoryId '),
          (ScriptBlock ' Get-LocationPowerLine -MaxSegmentCount 4 '),(ScriptBlock ' Write-GitStatusPowerLine '),
          (ScriptBlock ' "`t" '),
          (ScriptBlock ' Get-BatteryStatusPowerLine '),
          (ScriptBlock ' New-PromptText -Fg White (Get-Elapsed) '),(ScriptBlock ' New-PromptText -Fg White (Get-Date -f "T") '),(ScriptBlock '
              $jobs = Get-Job -State Running
              if ($jobs) {
                  "`n"
                  $jobs |
                      ForEach-Object { "@{0}" -f $_.Id } |
                      Join-String -OutputPrefix "Jobs: " -Separator ", " |
                      New-PromptText -Bg "#333333" -Fg Gray
              }
          '),(ScriptBlock ' "`n" '),
          (ScriptBlock ' New-PromptText -Fg Green -EFg Red -Bg Black "❯" ')
      )
      PowerLineFont = $True
      DefaultAddIndex = -1
      FullColor = $True
      RestoreVirtualTerminal = $True
      SetCurrentDirectory = $True
    }
    ExtendedCharacters = @{
      ColorSeparator = ''
      ReverseColorSeparator = ''
      Separator = ''
      ReverseSeparator = ''
      Branch = ''
      Lock = ''
      Gear = '⛯'
      Power = '⚡'
    }
  }
  