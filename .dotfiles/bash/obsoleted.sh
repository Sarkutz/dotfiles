# obsoleted.sh
#
# *Contains code that has been obsoleted*.
#
# Usage: To enable any code here, copy it to a file.


# toggle_server: Quick switch between apache and nginx
# Removed from home.sh as we are only going to use Nginx
function toggle_server()
{
    if [[ -z "$1" ]]
    then
        echo "usage: toggle_server webserver"
        echo "       webserver := apache | nginx"
        echo "       apache := 'a' | 'apache2'"
        echo "       nginx := 'n' | 'nginx'"

        return 1
    fi

	if [[ "$1" == 'a' ]] || [[ "$1" == 'apache2' ]]
	then
		from='nginx'
		to='apache2'

	elif [[ "$1" == 'n' ]] || [[ "$1" == 'nginx' ]]
	then
		from='apache2'
		to='nginx'
	fi

	sudo "/etc/init.d/${from}" stop
	sudo "/etc/init.d/${to}" start
}


# restart_server: Restart running apache or nginx
# Removed from home.sh as we are only going to use Nginx
function restart_server()
{
    SERVICE='apache2'

    nbr_nginx=$( ps auxc | egrep -w 'nginx' - | wc -l )
    [[ $nbr_nginx -ge 1 ]] && SERVICE=nginx

    sudo "/etc/init.d/${SERVICE}" restart
}


# Email toolchain
# ---------------
# Removed from home.sh as we are not using mutt email toolchain anymore. :(

# run_offlineimap: Quick download of emails
# Caller should deal with filtering before calling.
# USAGE: run_offlineimap
function run_offlineimap()
{
        offlineimap -qf INBOX &> ~/.offlineimap/output.log
        if [[ $? -ne 0 ]]
        then
            echo 'offlineimap failed.'
            exit
        fi
        echo "See ~/.offlineimap/output.log"
}


# syncmail: Apply IMAP filters to remote, and download result
# USAGE: syncmail ['quick']
# 'quick': don't filter; just download/delete new emails.
function syncmail()
{
    if [[ $1 == 'quick' ]]
    then
        run_offlineimap
        echo 'Quick email sync complete.'
        return 0
    fi

    # Clear the search mailbox before moving email.
    nbr_deleted=$( /bin/rm -f ${HOME}/Mail/pm-owa/search/cur/* | wc -l )
    echo "Deleted $nbr_deleted search entries."

    echo 'Running imapfilter ...'
    echo "tail -f ~/.imapfilter/output.log"
    imapfilter &> ~/.imapfilter/output.log
    if [[ $? -ne 0 ]]
    then
        echo 'imapfilter failed.'
        return 1
    fi

    echo 'Running offlineimap ...'
    echo "tail -f ~/.offlineimap/output.log"
    offlineimap &> ~/.offlineimap/output.log
    if [[ $? -ne 0 ]]
    then
        echo 'offlineimap failed.'
        return 1
    fi

    echo 'Running notmuch ...'
    notmuch new

    echo 'Email sync complete.'
    return 0
}
