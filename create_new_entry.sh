#!/bin/sh

# this script creates a new news entry
# it's a little smarter than it used to be to account for per-platform, per-branch updates
# You can still run it with just ./create_new_entry.sh but it will fill in some
# of the necessary fields for you and. You can also now pass it environment variables TITLE,
# HREF, and AUTHOR to set the title, href, and author of the entry.
#
# Example usage:
# TITLE="Update for Windows Jpackage 1.5.1" AUTHOR=idk EDITOR=mousepad I2P_OS=win I2P_BRANCH=beta ./create_new_entry.sh

ENTRIES=data/$I2P_OS/$I2P_BRANCH/entries.html
UUIDGEN="`which uuidgen || which uuid`"
DATE=$(date +%Y-%m-%dT%H:00:00Z)
if [ -z "$HREF" ]; then
    HREF="http://i2p-projekt.i2p/en/blog/post/"$(date +%Y)/$(date +%m)/$(date +%d)"/CHANGEME_URL_HERE"
fi

sed -i "3i <article\n  id=\"urn:uuid:`$UUIDGEN`\"\n  title=\"$TITLE\"\n  href=\"$HREF\"\n  author=\"$AUTHOR\"\n  published=\"$DATE\"\n  updated=\"$DATE\">\n<details>\n<summary></summary>\n</details>\n<p>\n\n</p>\n</article>\n\n\n" $ENTRIES

if [ ! -z "$EDITOR" ]; then
    case "$EDITOR" in
        "nano" | "vim")
            $EDITOR +13 $ENTRIES
            ;;
        *)
            $EDITOR $ENTRIES
            ;;
    esac
fi

