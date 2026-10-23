#set page(width: 841pt, height: 200pt, margin: 10pt)
#import "@preview/fletcher:0.5.8": diagram, node, edge
#import "diagram-etl.typ": etl-node

#diagram(
  spacing: (40pt, 12pt),
  etl-node((0, 0), logo: image("../images/presentation/logos/parquet.svg"), title: [explotaciones.parquet], subtitle: [262,546 filas], tag: [Entrada], name: <exp>),
  etl-node((0, 1), logo: image("../images/presentation/logos/parquet.svg"), title: [parcelas.parquet], subtitle: [Uso de tierra], tag: [Entrada], name: <parc>),
  etl-node((1, 0.5), logo: image("../images/presentation/logos/rust.svg"), title: [Rust + DataFusion], subtitle: [Hash Join por ID], tag: [Fase 2], name: <rust>),
  etl-node((2, 0.5), logo: image("../images/presentation/logos/parquet.svg"), title: [farms.parquet], subtitle: [Consolidado Snappy], tag: [Salida], name: <farms>),
  edge(<exp>, <rust>, "-|>"),
  edge(<parc>, <rust>, "-|>"),
  edge(<rust>, <farms>, "-|>"),
)
