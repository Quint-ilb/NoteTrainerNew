//
//  ParanadaView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 20/08/22.
//

import SwiftUI

struct SRParanadaView: View {
    
    @ObservedObject var vm: SRPlayerManager
    var tapIndicatorState : TapIndicatorState
   
    var notes: [Note] = [
        Note(noteType: .quarterNote, sound: Sound(tone: .C)), //0
        Note(noteType: .quarterNote, sound: Sound(tone: .D)),
        Note(noteType: .quarterNote, sound: Sound(tone: .E)),
        Note(noteType: .quarterNote, sound: Sound(tone: .F)),
        Note(noteType: .quarterNote, sound: Sound(tone: .G)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .A)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .B)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
    ]
    var notesBlock: [[Int]] = SRHelper.generateBlock(offsetBeat: 1, notes: [
        Note(noteType: .quarterNote, sound: Sound(tone: .C)),
        Note(noteType: .quarterNote, sound: Sound(tone: .D)),
        Note(noteType: .quarterNote, sound: Sound(tone: .E)),
        Note(noteType: .quarterNote, sound: Sound(tone: .F)),
        Note(noteType: .quarterNote, sound: Sound(tone: .G)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .A)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .B)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
    ])
//    [[1, 0], [0], [1, 1], [0], [1, 2], [0], [1, 3], [0], [1, 4], [0], [1, 5], [0], [1, 6], [0], [1, 7], [0], [1, 8], [0]]
    

    
    var body: some View {
        ZStack(alignment: .trailing){
            
            VStack(spacing: 18){
                ForEach((1...5).reversed(), id: \.self) {_ in
                    Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                    .foregroundColor(Color.grayColor)
                }
                
            }
            
            HStack {
                Image("kunciG")
            
                ZStack{
                    
                    HStack{
                        HStack(spacing: 0){
                            ForEach(Array(notesBlock.enumerated()), id: \.offset){ (i, block) in //[0], [1,2]
                                HStack{
                                    ZStack(alignment: .bottom){
                                        if(block.count > 1 && block[1] > 0) {
                                            Image(notes[block[1]-1].noteType.image)
                                                .resizable()
                                                .aspectRatio(1, contentMode: .fit)
                                                .frame(width: 50, height: 60, alignment: .bottom)
                                        }
                                        
                                        
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//                                                                .background(.pink)
                                        .offset(x: -25, y: block.count > 1 && block[1] > 0 ? notes[block[1]-1].sound.position * 18 : 0)
                                     //naik satu nada -10,5
                                    
                                }
                                .frame(width: 50, height: 71)
//                                                        .background(.purple.opacity(0.5))
                                                        .border(.yellow)
                                
                                
                            }
                        }
                                        
                        .offset(
//                            x: 80,
                            x: vm.playingTimestamp < vm.startTime ? 80 : countOffset(),
                                y: 0)
//                        .background(Color.white)
                        
                    }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    
                    
                    HStack{
                        ZStack(alignment: .trailing){
                            
                            Rectangle()
                                .frame(width: 80, height: 80)
                                .foregroundColor(tapIndicatorState.color)
                                .opacity(0.5)
                            
                            Rectangle()
                                .frame(width: 5, height: 100)
                                .foregroundColor(tapIndicatorState.color)
                        }
                        Spacer()
                    }
                    
                }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity, alignment: .leading)
//                    .background(Color.brownColor)
                    .clipped()
                
            }
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity, alignment: .leading)
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        //            .background(Color.blue)
        
    }
    
    func countOffset() -> CGFloat {
//        let x = 80
   
        let percentageTime = (vm.playingTimestamp - vm.startTime) / vm.totalInterval
        let offsetSong = Double(notesBlock.count * 50) * Double(percentageTime) * -1.00
        
//        print(offsetSong + 80)
        return offsetSong + 80
//        return CGFloat( notesBlock.count * 50 * -1 )
    }
}

struct SRParanadaView_Previews: PreviewProvider {
    static var previews: some View {
        SRParanadaView(vm: SRPlayerManager(notes: [], offsetBpm: 1), tapIndicatorState: .neutral)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}