# Бизнес-процесс компании MicroIS
Бизнес-процесс компании MicroIS (аналог российской Micron). Описание работы завода MicroIS по производству электронных компонентов (либо небольших микросхем, либо транзисторов, фотоэлементов и т.д.). Реализовано с помощью **MySQL** и **Workbanch**.

## Цели создания БД
- Оптимизация управления производственными процессами.
- Эффективное управление складом и отслеживание товарного оборота.
- Анализ эффективности работы производства и продаж для принятия управленческих решений.
- Оценка производительности и эффективности сотрудников.
- Управление заказами и поставками.



# Документация

Количество таблиц - 8 (восемь)

Список таблиц
1.	**ordersAndDeliveries**
2.	**customers**
3.	**process**
4.	**productProcessLink**
5.	**products**
6.	**staff**
7.	**staffProcessLink**
8.	**storage**

### Связи между таблицами
1.	**products** <–> **process** – связь «Многие ко многим» через таблицу **productProcessLink**.
Связь происходит по полям **productProcessLink**._productId_ и **productProcessLink**._processId_ (эти поля ссылаются на соответственно поле _id_ в таблице **products** и **process**)
2.	**staff** <–> **process** – связь «Многие ко многим» через таблицу **staffProcessLink**.
Связь происходит по полям **staffProcessLink**._staffId_ и **staffProcessLink**._processId_ (эти поля ссылаются на соответственно поле _id_ в таблице **staff** и **process**)
3.	**storage** <–> **product** – связь «Один к одному». Связь происходит по полям **storage**._productID_ и  **products**._id_ (_productID_ ссылается на **products**._id_)
4.	**products** <–> **ordersAndDeliveries** <–> **customers** – связь «Многие ко многим». Связь происходит так: **ordersAndDeliveries**._customerId_ ссылается на **customers**._id_, и **ordersAndDeliveries**._productID_ ссылается на **products**.id


## Схема базы данных и таблиц

![image](https://github.com/domster704/micro-integral-circuit-db/assets/61056244/dcac16f5-5ea4-4c62-942b-d5058537fb79)

## Права доступа

1. **Администратор**:
    1. **Операции**: _обновление_, _удаление_, _добавление_
        1. Таблицы:
            1. ordersAndDeliveries
            2. customers
            3. process
            4. productProcessLink
            5. products
            6. staff
            7. staffProcessLink
            8. storage
3. **Менеджер**:
    1. **Операции**: _Добавление_
        1. Таблицы:
            1. products
            2. staff
            3. storage
            4. customers
            5. productProcessLink
            6. staffProcessLink
    2. **Операции**: _Обновление_
        1. Таблицы:
            1. storage
            2. ordersAndDeliveries
