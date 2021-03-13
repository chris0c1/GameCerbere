import QtQuick 2.10

Item{
    property string login: "login"
    property string color: "#000000"
    property int difficulty: 0
    property int rage: 0
    property int vitesse: 0
    property int posCerbere: 0
    property int pont: 1
    property variant players: []

    signal _loginChanged()
    signal _colorChanged()
    signal _difficultyChanged()
    signal _rageChanged()
    signal _vitesseChanged()
    signal _playersChanged(variant players)
    signal _positionChanged(string newPosition, string color)

    function changeLogin(newlogin) {
        login = newlogin
        _loginChanged()
    }

    function changeColor(newcolor) {
        color = newcolor
        _colorChanged()
    }

    function changeDifficulty(newDifficulty) {
        difficulty = newDifficulty
        _difficultyChanged()
    }

    function changeRage(newRage) {
        rage = newRage
        _rageChanged()
    }

    function changeVitesse(newVitesse) {
        vitesse = newVitesse
        _vitesseChanged()
    }

    function changePlayers(newPlayers) {
        players = newPlayers
        _playersChanged(players)
    }

    function changePosition(color, newPosition) {
        for (var i = 0; i < players.length; i++) {
            if (players[i].colour == color) {
                players[i].position == newPosition
                _positionChanged(newPosition, players[i].colour)
            }
        }
    }
    
    Component.onCompleted: {
        _loginChanged.connect(parent.board.playerInfo.updateLogin)
        _colorChanged.connect(parent.board.playerInfo.updateColor)
        _positionChanged.connect(parent.board.boardId.receiveCounter)
        _playersChanged.connect(parent.board.boardId.pionesId.unhideNonPlayerPieces)
    }
}