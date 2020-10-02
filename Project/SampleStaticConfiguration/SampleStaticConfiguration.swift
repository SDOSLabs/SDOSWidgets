//
//  SampleStaticConfiguration.swift
//  SampleStaticConfiguration
//
//  Created by Juan Miguel Fernández Lerena on 01/10/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct SampleStaticConfigurationEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct SampleStaticConfiguration: Widget {
    let kind: String = "SampleStaticConfiguration"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SampleStaticConfigurationEntryView(entry: entry)
        }
        .configurationDisplayName(NSLocalizedString("Static SDOSWidget", comment: ""))
        .description(NSLocalizedString("This is an example SDOSWidget.", comment: ""))
    }
}

struct SampleStaticConfiguration_Previews: PreviewProvider {
    static var previews: some View {
        SampleStaticConfigurationEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
