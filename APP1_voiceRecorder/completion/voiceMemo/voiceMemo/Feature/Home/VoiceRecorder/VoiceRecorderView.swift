//
//  VoiceRecorderView.swift
//  voiceMemo
//

import SwiftUI

struct VoiceRecorderView: View {
  @StateObject private var voiceRecorderViewModel = VoiceRecorderViewModel()
  @EnvironmentObject private var homeViewModel: HomeViewModel
  
  var body: some View {
    ZStack {
      VStack {
        TitleView()
        
        if voiceRecorderViewModel.recordedFiles.isEmpty {
          AnnouncementView()
        } else {
          VoiceRecorderListView(voiceRecorderViewModel: voiceRecorderViewModel)
            .padding(.top, 15)
        }
        
        Spacer()
      }
      
      RecordBtnView(voiceRecorderViewModel: voiceRecorderViewModel)
        .padding(.trailing, 20)
        .padding(.bottom, 50)
    }
    .alert(
      "선택된 음성메모를 삭제하시겠습니까?",
      isPresented: $voiceRecorderViewModel.isDisplayRemoveVoiceRecorderAlert
    ) {
      Button("삭제", role: .destructive) {
        voiceRecorderViewModel.removeSelectedVoiceRecord()
      }
      Button("취소", role: .cancel) { }
    }
    .alert(
      voiceRecorderViewModel.alertMessage,
      isPresented: $voiceRecorderViewModel.isDisplayAlert
    ) {
      Button("확인", role: .cancel) { }
    }
    .onChange(
      of: voiceRecorderViewModel.recordedFiles,
      perform: { recordedFiles in
        homeViewModel.setVoiceRecordersCount(recordedFiles.count)
      }
    )
  }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
  fileprivate var body: some View {
    HStack {
      Text("음성메모")
        .font(.system(size: 30, weight: .bold))
        .foregroundColor(.customBlack)
      
      Spacer()
    }
    .padding(.horizontal, 30)
    .padding(.top, 30)
  }
}

// MARK: - 음성메모 안내 뷰
private struct AnnouncementView: View {
  fileprivate var body: some View {
    VStack(spacing: 15) {
      Rectangle()
        .fill(Color.customCoolGray)
        .frame(height: 1)
      
      Spacer()
        .frame(height: 180)
      
      Image("pencil")
        .renderingMode(.template)
      Text("현재 등록된 음성메모가 없습니다.")
      Text("하단의 녹음 버튼을 눌러 음성메모를 시작해주세요.")
      
      Spacer()
    }
    .font(.system(size: 16))
    .foregroundColor(.customGray2)
  }
}

// MARK: - 음성메모 리스트 뷰
private struct VoiceRecorderListView: View {
  @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
  
  fileprivate init(voiceRecorderViewModel: VoiceRecorderViewModel) {
    self.voiceRecorderViewModel = voiceRecorderViewModel
  }
  
  fileprivate var body: some View {
    ScrollView(.vertical) {
      VStack {
        Rectangle()
          .fill(Color.customGray2)
          .frame(height: 1)
        
        ForEach(voiceRecorderViewModel.recordedFiles, id: \.self) { recordedFile in
          VoiceRecorderCellView(
            voiceRecorderViewModel: voiceRecorderViewModel,
            recordedFile: recordedFile
          )
        }
      }
    }
  }
}

// MARK: - 음성메모 셀 뷰
private struct VoiceRecorderCellView: View {
  @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
  private var recordedFile: URL
  private var creationDate: Date?
  private var duration: TimeInterval?
  private var progressBarValue: Float {
    if voiceRecorderViewModel.selectedRecoredFile == recordedFile
        && (voiceRecorderViewModel.isPlaying || voiceRecorderViewModel.isPaused) {
      return Float(voiceRecorderViewModel.playedTime) / Float(duration ?? 1)
    } else {
      return 0
    }
  }
  
  fileprivate init(
    voiceRecorderViewModel: VoiceRecorderViewModel,
    recordedFile: URL
  ) {
    self.voiceRecorderViewModel = voiceRecorderViewModel
    self.recordedFile = recordedFile
    (self.creationDate, self.duration) = voiceRecorderViewModel.getFileInfo(for: recordedFile)
  }
  
  fileprivate var body: some View {
    VStack {
      Button(
        action: {
          voiceRecorderViewModel.voiceRecordCellTapped(recordedFile)
        },
        label: {
          VStack {
            HStack {
              Text(recordedFile.lastPathComponent)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.customBlack)
              
              Spacer()
            }
            
            Spacer()
              .frame(height: 5)
            
            HStack {
              if let creationDate = creationDate {
                Text(creationDate.fomattedVoiceRecorderTime)
                  .font(.system(size: 14))
                  .foregroundColor(.customIconGray)
              }
              
              Spacer()
              
              if voiceRecorderViewModel.selectedRecoredFile != recordedFile,
                 let duration = duration {
                Text(duration.formattedTimeInterval)
                  .font(.system(size: 14))
                  .foregroundColor(.customIconGray)
              }
            }
          }
        }
      )
      .padding(.horizontal, 20)
      
      if voiceRecorderViewModel.selectedRecoredFile == recordedFile {
        VStack {
          ProgressBar(progress: progressBarValue)
            .frame(height: 2)
          
          Spacer()
            .frame(height: 5)
          
          HStack {
            Text(voiceRecorderViewModel.playedTime.formattedTimeInterval)
              .font(.system(size: 10, weight: .medium))
              .foregroundColor(.customIconGray)
            
            Spacer()
            
            if let duration = duration {
              Text(duration.formattedTimeInterval)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.customIconGray)
            }
          }
          
          Spacer()
            .frame(height: 10)
          
          HStack {
            Spacer()
            
            Button(
              action: {
                if voiceRecorderViewModel.isPaused {
                  voiceRecorderViewModel.resumePlaying()
                } else {
                  voiceRecorderViewModel.startPlaying(recordingURL: recordedFile)
                }
              },
              label: {
                Image("play")
                  .renderingMode(.template)
                  .foregroundColor(.customBlack)
              }
            )
            
            Spacer()
              .frame(width: 10)
            
            Button(
              action: {
                if voiceRecorderViewModel.isPlaying {
                  voiceRecorderViewModel.pausePlaying()
                }
              },
              label: {
                Image("pause")
                  .renderingMode(.template)
                  .foregroundColor(.customBlack)
              }
            )
            
            Spacer()
            
            Button(
              action: {
                voiceRecorderViewModel.removeBtnTapped()
              },
              label: {
                Image("trash")
                  .renderingMode(.template)
                  .resizable()
                  .frame(width: 30, height: 30)
                  .foregroundColor(.customBlack)
              }
            )
          }
        }
        .padding(.horizontal, 20)
      }
      
      Rectangle()
        .fill(Color.customGray2)
        .frame(height: 1)
    }
  }
}

// MARK: - 프로그레스 바
private struct ProgressBar: View {
  private var progress: Float
  
  fileprivate init(progress: Float) {
    self.progress = progress
  }
  
  fileprivate var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(Color.customGray2)
        
        Rectangle()
          .fill(Color.customGreen)
          .frame(width: CGFloat(self.progress) * geometry.size.width)
      }
    }
  }
}

// MARK: - 녹음 버튼 뷰
private struct RecordBtnView: View {
  @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
  @State private var isAnimation: Bool
  
  fileprivate init(
    voiceRecorderViewModel: VoiceRecorderViewModel,
    isAnimation: Bool = false
  ) {
    self.voiceRecorderViewModel = voiceRecorderViewModel
    self.isAnimation = isAnimation
  }
  
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
        
        Button(
          action: {
            voiceRecorderViewModel.recordBtnTapped()
          },
          label: {
            if voiceRecorderViewModel.isRecording {
              Image("mic_recording")
                .scaleEffect(isAnimation ? 1.5 : 1)
                .onAppear {
                  withAnimation(.spring().repeatForever()) {
                    isAnimation.toggle()
                  }
                }
                .onDisappear {
                  isAnimation = false
                }
            } else {
              Image("mic")
            }
          }
        )
      }
    }
  }
}

struct VoiceRecorderView_Previews: PreviewProvider {
  static var previews: some View {
    VoiceRecorderView()
  }
}
