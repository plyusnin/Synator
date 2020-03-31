struct Station {
    var tasks: [Task]
}

#if DEBUG
let testStation = Station(tasks: [
    Task(id: 1, name: "Altered.Carbon.S02.WEBRip.2160p.H265.HDR"),
    Task(id: 2, name: "Homeland_Season_7_LostFilm_WEB-DL_1080p"),
    Task(id: 3, name: "What_We_Do_in_the_Shadows_Season_1_1080p_LostFilm"),
    Task(id: 4, name: "Sketch 64"),
])
#endif
