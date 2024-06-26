//
//  DollarView.swift
//  AppDolar
//
//  Created by Luciano Nicolini on 26/06/2024.
//

import SwiftUI

struct DollarView: View {
    
    let horizontalPadding: CGFloat = 30
    let index: AppDolar.DolarDataModel
    
    // Tabla de colores mejorada
    let colorTable: [String: Color] = [
        "Oficial": .green,
        "Blue": .blue,
        "Bolsa": .gray,
        "Solidario (Turista)": .yellow,
        "Mayorista": .orange,
        "Contado con liquidación": .red,
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            headerView()
                .padding(.horizontal, horizontalPadding)
                .padding(.top, 20)
            
            HStack {
                currencyDetailView(label: "Compra", value: index.compra)
                Divider()
                    .frame(height: 50)
                    .background(Color.primary)
                currencyDetailView(label: "Venta", value: index.venta)
            }
            .padding(.horizontal, horizontalPadding)
            
            Divider()
                .background(Color.primary)
            
            // Indicador de fecha de última actualización
            if let formattedDate = formattedDate(from: index.fechaActualizacion) {
                Text("Última actualización: \(formattedDate)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.top, 10)
                    .padding(.horizontal, horizontalPadding)
            }
        }
        .padding()
        .background(Color(.color))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    // Vista de encabezado refactorizada
    @ViewBuilder
    private func headerView() -> some View {
        HStack {
            Image(systemName: "dollarsign.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(colorTable[index.nombre] ?? .gray)
                .padding(.trailing)
            Text("Dólar \(index.nombre)")
                .font(.system(size: UIFontMetrics.default.scaledValue(for: 25), weight: .regular))
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    // Vista de detalles de moneda refactorizada
    @ViewBuilder
    private func currencyDetailView(label: String, value: Double?) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
            Text("$\(value ?? 0, specifier: "%.2f")")
                .font(.title2)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
    }
}

struct DollarView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DolarDataModel(
            compra: 94.0,
            venta: 100.0,
            casa: "Contado con liquidación",
            nombre: "Contado con liquidación", moneda: "5",
            fechaActualizacion: "2023-03-18T02:36:00.000Z"
        )
        DollarView(index: dataModel)
    }
}
