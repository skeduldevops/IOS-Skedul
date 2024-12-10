//
//  MainCalendar.swift
//  Skedul
//
//  Created by skedul on 31/10/24.
//

import SwiftUI

struct MainCalendar: View {
    private let calendar = Calendar.current
    private let months = Array(0..<12)

    var body: some View {
        VStack(spacing: 5) {
            SearchFields()
                .padding(.horizontal, 15)
            
            IconScrollHeader()
                .padding(.horizontal, 1)
                .padding(.bottom, 10)
                .padding(.top, 15)
                .padding(.leading, 20)
            
            
            ScrollView {
                LazyVStack(spacing: 50) {
                    ForEach(months, id: \.self) { monthOffset in
                        let date = Calendar.current.date(byAdding: .month, value: monthOffset, to: Date())!
                        MonthView(monthDate: date)
                            .padding(.bottom, 25)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Calendar")
            .padding(.top)
            .background(Color("MainColor3").opacity(0.1))
        }
    }
}


struct MonthView: View {
    let monthDate: Date

    var body: some View {
        VStack(alignment: .leading) {
            Text(monthTitle)
                .font(.custom("Poppins-ExtraBold", size: 26))
                .foregroundColor(Color("MainColor2"))
                .padding(.bottom, 25)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                Text("M")
                Text("T")
                Text("W")
                Text("T")
                Text("F")
                Text("S")
                Text("S")
            }
            .font(.custom("Poppins-Reguler", size: 16))
            .foregroundColor(Color("MainColor2"))
            .frame(maxWidth: .infinity)
            .padding(.bottom, 5)
            
            Divider()
                .background(Color("MainColor2").opacity(0.1))

            let days = generateDaysInMonth(for: monthDate)
            let rows = days.chunked(into: 7)

            ForEach(rows, id: \.self) { week in
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                    ForEach(week, id: \.self) { day in
                        Text(day)
                            .frame(width: 25, height: 25)
                            .padding(self.isToday(day: day) ? 0 : 15)
                            .font(.custom("Poppins-Reguler", size: 16))
                            .foregroundColor(self.isToday(day: day) ? Color("MainColor2") : Color("MainColor2"))
                            .background(self.isToday(day: day) ? Color("MainColor1") : Color.clear)
                            .cornerRadius(self.isToday(day: day) ? 6 : 0)
                            .padding(self.isToday(day: day) ? 15 : 0)
                            .clipShape(RoundedRectangle(cornerRadius: self.isToday(day: day) ? 12 : 0))
                    }
                }
                
                Divider()
                    .background(Color("MainColor2").opacity(0.1))
            }
        }
    }

    private var monthTitle: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: monthDate)
    }

    private func generateDaysInMonth(for date: Date) -> [String] {
        let range = Calendar.current.range(of: .day, in: .month, for: date)!
        let days = range.map { "\($0)" }

        let firstDay = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: date))!
        let weekdayOffset = Calendar.current.component(.weekday, from: firstDay) - 1

        return Array(repeating: "", count: weekdayOffset) + days
    }

    private func isToday(day: String) -> Bool {
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dayInt = Int(day) ?? 0
        return today.day == dayInt && today.month == Calendar.current.component(.month, from: monthDate)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

#Preview {
    MainCalendar()
}
