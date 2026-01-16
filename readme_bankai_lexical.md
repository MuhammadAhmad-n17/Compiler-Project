# Compiler Project – Bankai Language

**Course:** Compiler Construction  
**Project Phases:** Phase 01 (Lexical Analysis) & Phase 02 (Syntax Analysis)

---

## 📌 Project Overview

This project implements a **mini C++-like language** called **Bankai Language** as part of the Compiler Construction course.

- **Phase 01:** Lexical Analyzer using **Flex**
- **Phase 02:** Syntax Analyzer (Parser) using **Bison/YACC**

The language uses custom keywords such as `int_bankai`, `if_bankai`, and `display_bankai` while following C++-style syntax.

---

## 🧠 Language Features

- Variable declaration (`int_bankai`, `float_bankai`)
- Assignment statements
- Conditional statements (`if_bankai`, `else_bankai`)
- Loop constructs (`while_bankai`, `for_bankai`)
- Input / Output (`cin_bankai >>`, `display_bankai <<`)
- Arithmetic operations (`add+`, `sub-`, `mul*`, `div/`, `rem%`)
- Relational operator (`==`)

---

## 📁 Project Structure

```
Compiler-Project/
│
├── scanner.l        # Phase 01: Lexical Analyzer (Flex)
├── parser.y         # Phase 02: Syntax Analyzer (Bison)
├── valid.txt        # Valid test program
├── invalid.txt      # Invalid test program
├── tokens.txt       # Token output from Phase 01
├── README.md        # Project documentation
```

---

## 🛠️ Tools & Technologies Used

- **Flex** – for lexical analysis
- **Bison / YACC** – for syntax analysis
- **GCC** – to compile generated C code
- **Ubuntu Linux** (Virtual Machine)

---

## ⚙️ How to Compile and Run (Ubuntu)

### Step 1: Install Required Tools (Run once)

```bash
sudo apt update
sudo apt install flex bison gcc -y
```

---

### Step 2: Generate Lexer (Phase 01)

```bash
flex scanner.l
```

This will generate:

```
lex.yy.c
```

---

### Step 3: Generate Parser (Phase 02)

```bash
bison -d parser.y
```

This will generate:

```
parser.tab.c
parser.tab.h
```

---

### Step 4: Compile the Compiler

```bash
gcc lex.yy.c parser.tab.c -o bankai
```

---

### Step 5: Run with Test Files

#### Valid Program

```bash
./bankai < valid.txt
```

Expected Output:

```
Syntax analysis successful
```

#### Invalid Program

```bash
./bankai < invalid.txt
```

Expected Output:

```
Syntax Error at line 1
```

---

## 🧪 Test Files

- **valid.txt**  
  Contains a syntactically correct Bankai program.

- **invalid.txt**  
  Contains a program with syntax errors to demonstrate error handling.

---

## ❗ Error Handling

- Syntax errors are detected during parsing.
- Line number of the error is reported.
- Errors occur when grammar rules are violated (e.g., missing identifier, missing semicolon).

---

## 🎓 Academic Notes

- Phase 02 strictly reuses tokens from Phase 01.
- Grammar is implemented as a **Context-Free Grammar (CFG)** inside `parser.y`.
- FIRST and FOLLOW sets, parse trees, and ambiguity analysis are documented separately as part of the assignment submission.
- This project follows standard compiler design principles as described in the **Dragon Book**.

---

## ✅ Project Status

- ✔ Phase 01 completed (Lexical Analyzer)
- ✔ Phase 02 completed (Syntax Analyzer)
- ✔ Tested with valid and invalid inputs
- ✔ Ready for evaluation and viva

---

## 👤 Author

**Muhammad Ahmad**  
Compiler Construction – Semester Project
