######################################################################
#<
#
# Function: p6df::modules::db::version()
#
#>
######################################################################
p6df::modules::sqlserver::version() { echo "0.0.1" }

######################################################################
#<
#
# Function: p6df::modules::db::external::brew()
#
#>
######################################################################
p6df::modules::sqlserver::external::brew() {

  brew tap microsoft/mssql-release
  brew install msodbcsql # XXX: fix prompt for EULA
  brew install mssql-tools

  docker pull mcr.microsoft.com/mssql/server
}

######################################################################
#<
#
# Function: p6df::modules::db::home::symlink()
#
#>
######################################################################
p6df::modules::sqlserver::home::symlink() {

}

p6df::modules::sqlserver::init() {

}

p6df::modules::sqlserver::run() {

  local now_eps=$(p6_dt_now_epoch_seconds)

  docker run -d --name sqlserver-${now_eps} -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=$SA_PASSWORD' -p 1433:1433 microsoft/mssql-server-linux
}

p6_sqlcmd() {

  sqlcmd -S localhost -U sa -P $SA_PASSWORD
}
