import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
	id: game

	property var players: [{name:"KEK"}]
	Lobby {
		anchors.fill: parent
	}
}
