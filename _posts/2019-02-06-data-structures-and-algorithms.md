---
title: Data Structures and Algorithms Overview 
date: 2019-02-05 11:33:00 +0800
categories: [Blog]
tags: [Data Structures, Algorithms]
pin: false
math: true
mermaid: true
image:
  path: Data Structures and Algorithms.png
  alt: Data Structures and Algorithms
---

Data structures and algorithms are fundamental concepts in computer science that form the building blocks of efficient and organized software development. They play a crucial role in solving complex problems and optimizing the performance of software applications.

In this overview, we will explore some of the most common data structures and algorithms using `C`/`C++`.

Table of Contents

- [Data Structures](#data-structures)
  - [Arrays](#arrays)
  - [Linked Lists](#linked-lists)
  - [Stacks](#stacks)
  - [Queues](#queues)
  - [Trees](#trees)
  - [Graphs](#graphs)
- [Algorithms](#algorithms)
  - [Sorting Algorithms](#sorting-algorithms)
  - [Searching Algorithms](#searching-algorithms)
  - [Graph Algorithms](#graph-algorithms)
- [Conclusion](#conclusion)
  - [Ressource](#ressource)

## Data Structures

Data structures are ways to organize and store data efficiently. Common data structures include arrays, linked lists, trees etc..

---

### Arrays

An array is a collection of elements of the same data type stored in contiguous memory locations. In `C`, arrays are declared using square brackets `[]` and can be accessed by their index.

```c
int arr[5] = {1, 2, 3, 4, 5};
```

### Linked Lists

A linked list is a linear data structure consisting of nodes, where each node contains data and a reference (pointer) to the next node. Linked lists can be used to implement dynamic data structures like stacks and queues.

There are several types of linked lists, each with its own characteristics and use cases. Here are some common types of linked lists:

- **Singly Linked List**: In a singly linked list, each node contains a data element and a reference (pointer) to the next node in the sequence. It forms a unidirectional chain where traversal is possible only in one direction, from the head (first node) to the tail (last node).

```c
struct Node {
    int data;
    Node* next;
};
```

- **Doubly Linked List**: A doubly linked list extends the singly linked list by having each node contain references to both the next and the previous nodes. This bidirectional linking allows for traversal in both forward and backward directions.

```c
struct Node{
    Node *Prev;
    int data;
    Node* next;
};
```

- **Circular Linked List**: In a circular linked list, the last node of the list points back to the first node, forming a closed loop. This can be implemented using singly or doubly linked nodes. Circular linked lists are used in applications where continuous looping is required, such as scheduling algorithms.

```c
struct Node{
    int data;
    struct Node* next;
}
```

### Stacks

A stack is a data structure that follows the Last-In-First-Out (`LIFO`) principle. It is often used for managing function calls, undo functionality, and expression evaluation.

```cpp
std::stack<int> myStack;
myStack.push(1);
myStack.push(2);
int topElement = myStack.top();
```

### Queues

A queue is a data structure that follows the First-In-First-Out (`FIFO`) principle. It is used for tasks like managing tasks in a print queue or implementing `BFS` in graphs.

```cpp
std::queue<int> myQueue;
myQueue.push(1);
myQueue.push(2);
int frontElement = myQueue.front();
```

### Trees

Trees are hierarchical data structures that consist of nodes connected by edges. `Binary trees`, `binary search trees`, and `AVL trees` are commonly used variations.

```cpp
class TreeNode {
public:
    int data;
    TreeNode* left;
    TreeNode* right;
};
```

### Graphs

Graphs consist of a set of nodes (or vertices) and edges connecting these nodes. Graphs are incredibly versatile and can represent many different types of information in various fields, such as social networks, computer networks, biological networks, and transportation systems.

```c++

class Graph {
private:
    std::map<int, std::list<int>> adjList; // adjacency list

public:
    // Function to add an edge to the graph
    void addEdge(int u, int v, bool bidir = true) {
        adjList[u].push_back(v);
        if (bidir) {
            adjList[v].push_back(u);
        }
    }

};

```

---

## Algorithms

Algorithms are step-by-step procedures for solving problems or performing tasks.

---

### Sorting Algorithms

Sorting algorithms arrange elements in a specific order. Some common sorting algorithms include Bubble Sort, Insertion Sort, Selection Sort, Merge Sort, and Quick Sort.

```cpp
std::vector<int> myvector = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5};
std::sort(myvector.begin(), myvector.end());
```

### Searching Algorithms

Searching algorithms find a specific element in a data structure. `Linear Search` and `Binary Search` are commonly used searching algorithms.

```cpp
int linearSearch(const std::vector<int>& arr, int target) {
    for (int i = 0; i < arr.size(); ++i) {
        if (arr[i] == target) {
            return i;
        }
    }
    return -1;
}
```

### Graph Algorithms

Graph algorithms solve problems related to graphs, such as finding shortest paths, traversing graphs, and detecting cycles. Depth-First Search (`DFS`) and Breadth-First Search (`BFS`) are fundamental graph traversal algorithms.

```cpp
void DFS(Graph& graph, int startVertex) {
    std::stack<int> stack;
    stack.push(startVertex);
    std::vector<bool> visited(graph.getNumVertices(), false);

    while (!stack.empty()) {
        int vertex = stack.top();
        stack.pop();

        if (!visited[vertex]) {
            visited[vertex] = true;
            std::cout << "Visited vertex: " << vertex << std::endl;

            std::vector<int> neighbors = graph.getNeighbors(vertex);
            for (int neighbor : neighbors) {
                if (!visited[neighbor]) {
                    stack.push(neighbor);
                }
            }
        }
    }
}
```

---

## Conclusion

Data structures and algorithms are essential tools for solving real-world problems efficiently. The choice of the right data structure and algorithm can greatly impact the performance and functionality of your software. Continuous learning and practice are key to mastering these concepts and becoming a proficient programmer.

### Ressource

- [Collection of data structures](https://github.com/wilfrantz/C-Data-Structures){:target="_blank"}
