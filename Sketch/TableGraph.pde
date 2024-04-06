class Graph {
    private ArrayList<Table> tables;
    private ArrayList<ArrayList<Table>> adjacencyList;

    Graph(ArrayList<Table> tables) {
        this.tables = tables;
        this.adjacencyList = new ArrayList<ArrayList<Table>>();
        initializeAdjacencyList();
    }

    private void initializeAdjacencyList() {
        for (int i = 0; i < tables.size(); i++) {
            adjacencyList.add(new ArrayList<Table>());
        }
    }

    void addEdge(Table table1, Table table2) {
        int index1 = tables.indexOf(table1);
        int index2 = tables.indexOf(table2);

        if (index1 != -1 && index2 != -1) {
            adjacencyList.get(index1).add(table2);
            adjacencyList.get(index2).add(table1);
        }
    }

    ArrayList<Table> getAdjacentTables(Table table) {
        int index = tables.indexOf(table);
        if (index != -1) {
            return adjacencyList.get(index);
        }
        return new ArrayList<Table>();
    }
    
        void printGraph() {
        for (int i = 0; i < tables.size(); i++) {
            Table currentTable = tables.get(i);
            ArrayList<Table> adjacentTables = adjacencyList.get(i);

            System.out.print("Table " + currentTable.getNumero() + " is adjacent to: ");
            for (Table adjacentTable : adjacentTables) {
                System.out.print(adjacentTable.getNumero() + " ");
            }
            System.out.println();
        }
    }
}

void createGraph() {
    tableGraph = new Graph(masalle.getList());

    for (int i = 0; i < masalle.getList().size(); i++) {
        Table table1 = masalle.getList().get(i);

        for (int j = i + 1; j < masalle.getList().size(); j++) {
            Table table2 = masalle.getList().get(j);

            float distance = table1.distTable(table2);

            if (distance <= max(largeurTable,longueurTable+50)) {
                tableGraph.addEdge(table1, table2);
            }
        }
    }
}
