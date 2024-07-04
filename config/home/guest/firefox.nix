{...}: {
  programs.firefox = {
    enable = true;

    profiles."guest" = {
      bookmarks = [
        {
          name = "Coding Club Bordeaux";
          url = "https://codingclubbordeaux.github.io";
        }
        {
          name = "GitHub";
          url = "https://github.com/CodingClubBordeaux";
        }
      ];

      settings = {
        "middlemouse.paste" = false;
        "browser.startup.homepage" = "https://codingclubbordeaux.github.io";
        "browser.startup.firstrunSkipsHomepage" = false;

        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "trailhead.firstrun.branches" = "nofirstrun-empty";
        "browser.aboutwelcome.enabled" = false;

        "browser.toolbars.bookmarks.visibility" = "always";

        "browser.translations.neverTranslateLanguages" = "fr";
      };
    };
  };
}
