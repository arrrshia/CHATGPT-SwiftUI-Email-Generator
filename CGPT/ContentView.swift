//
//  ContentView.swift
//  CGPT
//
//  Created by Andrew Almasi on 12/13/22.
//

import SwiftUI
import Neumorphic
import OpenAISwift

final class ViewModel: ObservableObject {
    init() {}
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    func send(text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure:
                break
            }
        })
    }
}


struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var exampleText = ""
    @State var finalText: String
    @State var moodp = ""
    @State var generate = true
    @FocusState var textisfocused: Bool
    @State var mood = ""
    @State var lenp = ""
    let array = ["Ask my boss for a raise...", "Ask my professor for a curve...", "Ask my girlfriend to marry me...", "Ask my professor for a rec letter...", "Ask my mom how she's doing...", "Ask my brother if he's doign well...", "Tell my boss im quitting...", "Tell my coworkers to get to work...", "Ask my colleagues for help on..."]
    
    @State var length = ""
    @State var models = [String]()
    @State var showingResult = false

    
    @State var showUserSheet = false
    
    init() {
        self.finalText = array.randomElement()!
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Spacer()
                    VStack(alignment: .center){
                        VStack {
                            HStack(spacing: 5) {
                                Group {
                                    Button{
                                        mood = "Formal"
                                        moodp = "Formal"
                                    } label: {
                                        Text("Formal")
                                    }.font(.headline)
                                        .tint(moodp == "Formal" ? Color(uiColor: UIColor(red: 0.74, green: 0.42, blue: 0.15, alpha: 1.00)) : Color(uiColor: UIColor(red: 0.91, green: 0.44, blue: 0.32, alpha: 1.00)))
                                    
                                    Button{
                                        mood = "Friendly"
                                        moodp = "Friendly"
                                    } label: {
                                        Text("Friendly")
                                    }.font(.headline)
                                        .tint(moodp == "Friendly" ? Color(uiColor: UIColor(red: 0.74, green: 0.42, blue: 0.15, alpha: 1.00)) : Color(uiColor: UIColor(red: 0.91, green: 0.44, blue: 0.32, alpha: 1.00)))
                                    
                                    Button{
                                        mood = "Persuasive"
                                        moodp = "Persuasive"
                                    } label: {
                                        Text("Persuasive")
                                    }.font(.headline.bold())
                                        .tint(moodp == "Persuasive" ? Color(uiColor: UIColor(red: 0.74, green: 0.42, blue: 0.15, alpha: 1.00)) : Color(uiColor: UIColor(red: 0.91, green: 0.44, blue: 0.32, alpha: 1.00)))
                                }.buttonStyle(.bordered)
                                    .tint(Color(uiColor: UIColor(red: 0.91, green: 0.44, blue: 0.32, alpha: 1.00)))
                                
                            }.padding()
                        }
                        HStack {
                            Group {
                                Button{
                                    length = "Short"
                                    lenp = "Short"
                                } label: {
                                    Text("Short")
                                }.font(.headline)
                                    .tint(lenp == "Short" ? Color(uiColor: UIColor(red: 0.74, green: 0.42, blue: 0.15, alpha: 1.00)) : Color(uiColor: UIColor(red: 0.91, green: 0.44, blue: 0.32, alpha: 1.00)))
                                
                                Button{
                                    length = "Medium"
                                    lenp = "Medium"
                                } label: {
                                    Text("Medium")
                                }.font(.headline)
                                    .tint(lenp == "Medium" ? Color(uiColor: UIColor(red: 0.74, green: 0.42, blue: 0.15, alpha: 1.00)) : Color(uiColor: UIColor(red: 0.91, green: 0.44, blue: 0.32, alpha: 1.00)))
                                
                                Button{
                                    length = "Long"
                                    lenp = "Long"
                                } label: {
                                    Text("Long")
                                }.font(.headline.bold())
                                    .tint(lenp == "Long" ? Color(uiColor: UIColor(red: 0.74, green: 0.42, blue: 0.15, alpha: 1.00)) : Color(uiColor: UIColor(red: 0.91, green: 0.44, blue: 0.32, alpha: 1.00)))
                                
                            }.buttonStyle(.bordered)
                                .tint(Color(uiColor: UIColor(red: 0.91, green: 0.44, blue: 0.32, alpha: 1.00)))
                        }
                        //TextField("Other", text: $mood)
                    }.padding()
                    Spacer()
                    VStack{
                        Text(exampleText)
                            .padding(.vertical)
                            .foregroundColor(Color(uiColor: UIColor().textColor))
                            .font(.headline.italic())
                        if #available(iOS 16.0, *) {
                            TextField("What's it about?", text: $text, axis: .vertical)
                                .lineLimit(5)
                                .padding(.vertical)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .font(.headline.italic())
                            //.frame(width: 350, height: 300)
                                .background(Color(uiColor: UIColor().textColor))
                                .clipShape(Capsule(style: .continuous))
                                .focused($textisfocused)
                        } else {
                            TextEditor(text: $text)
                                .frame(width: 350, height: 300)
                                .foregroundColor(.white)
                                .font(.headline.italic())
                                .background(Color(uiColor: UIColor().textColor))
                                .clipShape(Capsule(style: .continuous))
                                .border(.purple)
                                .padding()
                                .focused($textisfocused)
                        }
                    }
                    Spacer()
                    Spacer()
                    Button{
                        send()
                        // implement sending result to result view and moving
                        generate.toggle()
                        textisfocused.toggle()
                    } label: {
                        if (!generate) {
                            Label("Generating...", systemImage: "pencil.and.outline")
                        } else {
                            Label("Generate", systemImage: "pencil.and.outline")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .background(.ultraThinMaterial, in: Capsule())
                    .tint(Color(uiColor: UIColor(red: 0.91, green: 0.44, blue: 0.32, alpha: 1.00)))
                    .font(.title3.bold())
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: UIColor().bgColor))
            .onAppear {
                viewModel.setup()
                typeWriter()
            }
            .sheet(isPresented: $showingResult, content: {
                ResultView(response: models.last ?? "")
                    .ignoresSafeArea()
            })
            .sheet(isPresented: $showUserSheet, content: {
                // implement user
            })
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action:  {showUserSheet.toggle()}, label: {
                        Image(systemName: "person.circle.fill")
                    })
                }
            }
            
        }
        }
    
    func typeWriter(at position: Int = 0) {
        if position == 0 {
            exampleText = ""
        }
        if position < finalText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                exampleText.append(finalText[position])
                typeWriter(at: position + 1)
            }
        }
        //typeWriter()
    }
    
    func deleteText() {
        let position = exampleText.count
        if (position > 0) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                exampleText.removeLast()
                deleteText()
            }
        }
    }
    
    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        var t: String = "Write me an email." + " The tone is " + mood + ". " + "The length is " + length + ". " + text
        print(t)
        models.append(t)
        viewModel.send(text: t) { response in
            DispatchQueue.main.async {
                self.models.append(response)
                self.text = ""
                print(response)
                showingResult.toggle()
                generate.toggle()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
