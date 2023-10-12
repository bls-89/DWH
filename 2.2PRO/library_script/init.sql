CREATE TABLE IF NOT EXISTS public.Readers (
    library_card int not NULL,
    surname varchar not NULL,
    name varchar not NULL,
    patronymic varchar not NULL,
    adress varchar not NULL,
    phone int not NULL,
    PRIMARY KEY (library_card)
);

CREATE TABLE IF NOT EXISTS public.Publishing_houses (
    publishing_house_id int not NULL,
    name varchar not NULL,
    city varchar not NULL,
    PRIMARY KEY (publishing_house_id)
);

CREATE TABLE IF NOT EXISTS public.Books (
    id_book int not NULL,
    book_name varchar not NULL,
    year_of_publish int not NULL,
    pages_quantity int not NULL,
    cost int not NULL,
    number_of_copies int not NULL,
    publishing_house_id int not NULL,
    edition int,
    PRIMARY KEY (id_book),
    FOREIGN KEY(publishing_house_id)
    	REFERENCES Publishing_houses(publishing_house_id)
);

CREATE TABLE IF NOT EXISTS public.Authors (
    author_id int not NULL,
    surname varchar not NULL,
    name varchar not NULL,
    patronymic varchar,
    PRIMARY KEY (author_id)
);


CREATE TABLE IF NOT EXISTS public.Book_author (
    id_book int not NULL,
    author_id int not NULL,
    FOREIGN KEY(id_book)
    	REFERENCES books(id_book),
    FOREIGN KEY(author_id)
    	REFERENCES Authors(author_id)
);

CREATE TABLE IF NOT EXISTS public.Book_operations (
    operation_id int not NULL,
    id_book int not NULL,
    library_card int not NULL,
    operation boolean not NULL,
    date_of_operation date not NULL,
    PRIMARY KEY (operation_id),
    FOREIGN KEY(id_book)
    	REFERENCES books(id_book),
    FOREIGN KEY(library_card)
    	REFERENCES Readers(library_card)
);