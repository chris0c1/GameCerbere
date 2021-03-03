import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0


Row {
    /////// Send data to Piones.qml from main.qml 
    signal notifyPiones(string counter, string player) // Declare signal

    function receiveCounter(count,player) {
        notifyPiones(count,player)
    }

    Component.onCompleted: {
        notifyPiones.connect(pionesId.receiveCounterPiones) //connect button to Pion
    }
    //////////////////////////////////////////////

    id: rowId
    anchors.fill: parent

    Rectangle {
        id: firstPlateauid
        width: parent.width*29/100
        color: "transparent"
        height: parent.height
        border.color: "red"
        border.width: 1

        Piones {
            id: pionesId
        }

        Row {
            id:rowFirstPlateauid
            anchors.fill : parent

            Rectangle {
                id: ragecolumnId 
                width: 8/100* parent.width
                color: "transparent"
                height: parent.height
                border.color :"green"
                border.width: 1
            }
                        
            Rectangle {
                id : case0Id
                width: 14/100* parent.width
                height: 30/100 * parent.height
                y: height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn0
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }      
            }
            Rectangle {
                id : case1Id
                width: 13/100* parent.width
                height: 27/100 * parent.height
                y : height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn1
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id : case2Id
                width: 13/100* parent.width
                height: 36/100 *parent.height
                y : 85/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn2
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id : case3Id
                width: 13/100* parent.width
                height: 30/100*parent.height
                y: 85/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn3
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y  
                }
            }
            Rectangle {
                id: case4Id
                width: 13/100* parent.width
                height: 30/100*parent.height
                y : 145/100 * height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn4
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id:case5Id
                width: 13/100* parent.width
                height:30/100*parent.height
                y : 80/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn5
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id:case6Id
                width: 14/100* parent.width
                height:29/100*parent.height
                y : 142/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn6
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
        }
    }
    Rectangle {
        id: secondPlateauid
        width: 22/100* parent.width
        color: "transparent"
        height: parent.height
        border.color :"red"
        border.width: 1


        Row {
            id:rowSecondPlateauid
            anchors.fill : parent

            Rectangle {
                id : case7Id
                width: 23/100* parent.width
                height:25/100*parent.height
                y : 165/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn7
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Column {
                id : cases8_9id
                height: parent.height
                width: 28/100* parent.width
                y : 30/100*height
                spacing : 2/100*parent.height
                Rectangle {
                    id: case9Id
                    width: 60/100*parent.width
                    height : 18/100*parent.height
                    y : 110/100*height
                    x : 60/100*width
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                    Grid {
                        id:layoutPawn9
                        columns:2
                        spacing : 2
                        y : 1/5*parent.y
                    }
                }
                Rectangle {
                    id: case8Id
                    width: 80/100*parent.width
                    height: 25/100*parent.height
                    y : height
                    x : 10/100*width
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                    Grid {
                        id:layoutPawn8
                        columns:2
                        spacing : 2
                        y : 1/5*parent.y
                    }
                }
            }
            Rectangle {
                id: case10Id
                width: 15/100*parent.width
                height: 18/100*parent.height
                y : 103/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn10
                    columns:2
                    spacing : 2
                    y : 1/20*parent.y
                }
            }
            Column {
                id : cases11_12id
                height: parent.height
                width: 33/100* parent.width
                y : 27/100*height
                spacing : 2/100*parent.height
                Rectangle {
                    id: case11Id
                    width: 60/100*parent.width
                    height : 19/100*parent.height
                    y : 90/100*height
                    x : 22/100*width
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                    Grid {
                        id:layoutPawn11
                        columns:2
                        spacing : 2
                        y : parent.y
                    }
                }
                Rectangle {
                    id: case12Id
                    width: 70/100* parent.width
                    x : 40/100*width
                    height: 30/100* parent.height
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                    Grid {
                        id:layoutPawn12
                        columns:2
                        spacing : 2
                        y : 1/5*parent.y
                    }
                }
            }
        }   
    }

    Rectangle {
        id: thirdPlateauid
        width: 21/100* parent.width
        color: "transparent"
        height: parent.height
        border.color :"red"
        border.width: 1

        Row {
            id:rowThirdPlateauid
            anchors.fill : parent

            Rectangle {
                id: case13Id
                width: 25/100*parent.width
                height : 30/100*parent.height
                y : 120/100*height 
                x : 120/100*width
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn13
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }

            Column {
                id : cases14_15id
                height: 34/100*parent.height
                width: 33/100* parent.width
                y : height
                spacing : 3/100*parent.height
                Rectangle {
                    id: case14Id
                    width: 2/3*parent.width
                    height: 85/100*parent.height
                    x : 1/3*width
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                    Grid {
                        id:layoutPawn14
                        columns:2
                        spacing : 2
                        y : 1/5*parent.y
                    }
                }
                Rectangle {
                    id: case15Id
                    x: 75/100 * parent.x
                    width: 50/100* parent.width
                    height: 36/100* parent.height
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                    Grid {
                        id:layoutPawn15
                        columns:2
                        spacing : 2
                    }
                }
            }

            Column {
                id : cases16_17id
                height: 33/100*parent.height
                width: 33/100* parent.width
                y : height
                spacing : 3/100*parent.height
                Rectangle {
                    id: case17Id
                    x: 20/100 * parent.x
                    width: 80/100 * parent.width
                    height: 88/100*parent.height
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                    Grid {
                        id:layoutPawn17
                        columns:2
                        spacing : 2 
                    }
                }
                Rectangle {
                    id: case16Id
                    width: 60/100* parent.width
                    height: 45/100* parent.height
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                    Grid {
                        id:layoutPawn16
                        columns:2
                        spacing : 2
                    }    
                }
            }
        }    
    }

    Rectangle {
        id: endPlateauId
        width: 28/100* parent.width
        color: "transparent"
        height: parent.height
        border.color :"red"
        border.width: 1
        Row {
            id:rowEndPlateauid
            anchors.fill : parent
            Rectangle {
                id: case18Id
                width: 15/100*parent.width
                height : 1/4*parent.height
                y : 140/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn18
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id: case19Id
                width: 13/100*parent.width
                height : 1/4*parent.height
                y : 80/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn19
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id: case20Id
                width: 12/100*parent.width
                height : 1/4*parent.height
                y : 140/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn20
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id: case21Id
                width: 10/100*parent.width
                height : 1/4*parent.height
                y : 90/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn21
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
             Rectangle {
                id: case22Id
                width: 10/100*parent.width
                height : 1/4*parent.height
                y : 140/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn22
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id: caseBarqueId
                width: 13/100*parent.width
                height : 1/4*parent.height
                y : 130/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Column {
                    id:layoutPawnBarque
                    anchors.fill : parent
                    spacing : 2
                }
            }
        }       
    }
}
