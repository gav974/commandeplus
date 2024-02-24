class Settings
{
//recupère le numero de version de l'application
static var _versionServer;

  static get versionServer => _versionServer;

  static  set versionServer(value) {
    _versionServer = value;
  }

}