---
title: YAML extensive cheatsheet
date: 2024-09-05 11:33:00 +0800
categories: [Blogging, Tutorial]
tags: [YAML, devops]
pin: false 
math: true
mermaid: true
image: 
---

Here’s an extensive YAML (YAML Ain’t Markup Language) cheatsheet, covering basic syntax, advanced concepts, and usage tips:

### Basic YAML Syntax

1. **Key-Value Pair**

    ```yaml
    key: value
    ```

2. **Nested Objects**

    ```yaml
    parent:
      child: value
    ```

3. **Lists (Arrays)**

    ```yaml
    items:
      - item1
      - item2
      - item3
    ```

4. **Inline Lists**

    ```yaml
    items: [item1, item2, item3]
    ```

5. **Inline Dictionaries**

    ```yaml
    person: {name: John, age: 30}
    ```

6. **Comments**

    ```yaml
    # This is a comment
    ```

### Data Types

1. **String**

    ```yaml
    name: "John"
    ```

2. **Multiline String**

    ```yaml
    description: |
      This is a long
      multiline string.
    ```

    or folded style:

    ```yaml
    description: >
      This is a long
      folded string.
    ```

3. **Integer**

    ```yaml
    age: 30
    ```

4. **Float**

    ```yaml
    price: 99.99
    ```

5. **Boolean**

    ```yaml
    active: true
    ```

6. **Null**

    ```yaml
    key: null
    ```

### Advanced Syntax

1. **Anchors and Aliases**
    - Anchor: `&anchor_name`
    - Alias: `*anchor_name`

    ```yaml
    default_settings: &defaults
      retries: 3
      timeout: 60

    user_settings:
      <<: *defaults
      timeout: 30  # Override the default timeout
    ```

2. **Merging Keys**

    ```yaml
    defaults: &defaults
      setting1: default1
      setting2: default2

    custom:
      <<: *defaults
      setting2: custom2  # Overridden
      setting3: custom3
    ```

3. **Multiple Documents in One File**

    ```yaml
    ---
    document1:
      key1: value1
    ---
    document2:
      key2: value2
    ```

4. **Reference Reuse**

    ```yaml
    values:
      - &id001 42
      - *id001
    ```

5. **Multiline Folded Block**

    ```yaml
    description: >
      This is a multiline string
      with a folded style that will
      be rendered as a single line.
    ```

6. **Multiline Literal Block**

    ```yaml
    description: |
      This is a multiline string
      with literal style that will
      retain the newline characters.
    ```

### Common YAML Patterns

1. **Config Files**

    ```yaml
    version: 1.0
    environment: production
    server:
      port: 8080
      host: localhost
    ```

2. **Docker Compose Example**

    ```yaml
    version: "3.8"
    services:
      web:
        image: nginx
        ports:
          - "8080:80"
      db:
        image: postgres
        environment:
          POSTGRES_USER: user
          POSTGRES_PASSWORD: password
    ```

3. **Kubernetes Pod Configuration**

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: mypod
    spec:
      containers:
        - name: mycontainer
          image: nginx
          ports:
            - containerPort: 80
    ```

4. **CI/CD Pipeline Example**

    ```yaml
    stages:
      - build
      - test
      - deploy

    build_job:
      stage: build
      script:
        - make build

    test_job:
      stage: test
      script:
        - make test

    deploy_job:
      stage: deploy
      script:
        - make deploy
    ```

### Special Characters

1. **Reserved Characters**
    - `:` - Indicates a key-value separator.
    - `-` - Indicates an item in a list.
    - `#` - Used for comments.
    - `&` - Used for anchors.
    - `*` - Used for aliases.
    - `|` - Indicates a literal block scalar (preserves newlines).
    - `>` - Indicates a folded block scalar (folds newlines).
  
2. **Escaping Characters**

    ```yaml
    text: "This is a string with a special character: \t (tab)"
    ```

### YAML Best Practices

1. **Consistent Indentation**
   - Always use spaces for indentation, never tabs.
   - YAML does not allow mixed spaces and tabs.

2. **Avoid Trailing Whitespace**
   - YAML is sensitive to trailing spaces, which may cause parsing errors.

3. **Keep It Simple**
   - Avoid overcomplicating YAML with deeply nested structures. Aim for readability.

4. **Use Anchors and Aliases to DRY (Don’t Repeat Yourself)**
   - Use anchors and aliases to reduce repetition.

5. **Avoid Boolean Strings**
   - Words like `yes`, `no`, `on`, `off`, `true`, `false` can be misinterpreted as booleans. It’s best to wrap them in quotes:

     ```yaml
     setting: "yes"
     ```

### Error Handling and Debugging

1. **Indentation Errors**
    - YAML is strict about indentation levels. Always use consistent indentation (usually 2 or 4 spaces).

2. **Invalid Characters**
    - Avoid using special characters in keys unless quoted:

    ```yaml
    "key-with-special:characters": value
    ```

3. **Common Parsing Errors**
   - Ensure no tabs are used for indentation; YAML only supports spaces.
   - Check for colons `:` outside of keys.
