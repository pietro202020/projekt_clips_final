import tkinter
import customtkinter
from PIL import Image
from clips_integration import SystemEkspercki

questions_history = []
finished = False
selected_answer_var = None
system = None

def build_gui(root):
    # Ustawienia okna
    root.title("Board Game Expert System")
    root.geometry("700x500")
    root.configure(fg_color="#EAEAEA")
    root.grid_columnconfigure(0, weight=1)
    root.grid_rowconfigure(2, weight=1)
    banner_frame = customtkinter.CTkFrame(root, fg_color="#BA68C8", height=60)
    banner_frame.grid(row=0, column=0, columnspan=4, sticky="ew")
    banner_label = customtkinter.CTkLabel(
        banner_frame,
        text="Board Game Expert System",
        font=("Helvetica", 24, "bold"),
        text_color="white"
    )
    banner_label.pack(padx=20, pady=10)
    main_frame = customtkinter.CTkFrame(root, corner_radius=20, fg_color="#F3E5F5")
    main_frame.grid(row=1, column=0, columnspan=4, sticky="nsew", padx=20, pady=10)
    main_frame.grid_rowconfigure(1, weight=1)

    # Etykieta z pytaniem
    global question_label
    question_label = customtkinter.CTkLabel(
        master=main_frame,
        text="",
        font=("Helvetica", 16),
        text_color="black",
        fg_color="white",
        corner_radius=10,
        anchor="center",
        width=600,
        wraplength=600
    )
    question_label.grid(row=0, column=0, columnspan=2, padx=20, pady=(20,10), sticky="ew")
    global answers_frame
    answers_frame = customtkinter.CTkFrame(
        master=main_frame,
        fg_color="#F3E5F5"
    )
    answers_frame.grid(row=1, column=0, columnspan=2, sticky="nsew", padx=20, pady=10)
    bottom_frame = customtkinter.CTkFrame(root, fg_color="#EAEAEA")
    bottom_frame.grid(row=3, column=0, columnspan=4, sticky="ew", padx=20, pady=10)
    bottom_frame.grid_columnconfigure(1, weight=1)

    global retract_button
    retract_button = customtkinter.CTkButton(
        master=bottom_frame,
        text="Back",
        fg_color="#9E9E9E",
        text_color="white",
        corner_radius=8,
        command=on_retract,
        state="disabled"
    )
    retract_button.grid(row=0, column=0, padx=(0,10), pady=10, sticky="w")

    global confirm_button
    confirm_button = customtkinter.CTkButton(
        master=bottom_frame,
        text="Next",
        fg_color="#00796B",
        text_color="white",
        corner_radius=8,
        command=on_confirm,
        state="disabled"
    )
    confirm_button.grid(row=0, column=1, padx=(0,0), pady=10, sticky="e")

def load_clips_state():
    """
    Uruchamia reguły w CLIPS, sprawdza fakty (pytanie / wynik) i aktualizuje GUI.
    """
    global finished
    system.run()
    result_fact = None
    for fact in system.fakty():
        if fact.template.name == "wynik":
            result_fact = fact
            break
    if result_fact:
        display_result(result_fact[0])
        return
    question_fact = None
    for fact in system.fakty():
        if fact.template.name == "pytanie":
            question_fact = fact
            break
    if question_fact:
        display_question(question_fact[0], question_fact[1:])
    retract_button.configure(state="normal" if questions_history else "disabled")

def display_question(question_text, answers_list):
    global finished
    finished = False
    question_label.configure(text=question_text)
    for widget in answers_frame.winfo_children():
        widget.destroy()
    global selected_answer_var
    selected_answer_var = tkinter.IntVar(value=-1)
    for idx, ans in enumerate(answers_list):
        rb = customtkinter.CTkRadioButton(
            master=answers_frame,
            text=ans,
            variable=selected_answer_var,
            value=idx,
            command=enable_confirm,
            fg_color="#C5CAE9",
            border_width_checked=2,
            hover_color="#B39DDB"
        )
        rb.pack(anchor="w", pady=5, padx=10)

    confirm_button.configure(text="Next", state="disabled")

def display_result(result_text):
    """
    Wyświetla końcowy wynik i zmienia przycisk "Next" na "Exit".
    """
    global finished
    finished = True

    question_label.configure(text=f"Suggested Game: {result_text}")
    for widget in answers_frame.winfo_children():
        widget.destroy()

    confirm_button.configure(text="Exit", state="normal")

def enable_confirm():
    """
    Odblokowuje przycisk Next w momencie wybrania odpowiedzi przez użytkownika.
    """
    confirm_button.configure(state="normal")

def on_confirm():
    """
    Obsługa kliknięcia przycisku Next/Exit.
    """
    global finished
    if finished:
        root.quit()
        return

    idx = selected_answer_var.get()
    if idx < 0:
        return  # nic nie wybrano
    question_text = question_label.cget("text")
    children = answers_frame.winfo_children()
    answers_list = [child.cget("text") for child in children]
    answers_joined = " ".join([f'"{a}"' for a in answers_list])
    questions_history.append(f'"{question_text}" {answers_joined}')

    chosen_answer_text = children[idx].cget("text")
    system.odpowiedz(chosen_answer_text)

    load_clips_state()

def on_retract():
    """
    Cofamy do poprzedniego pytania, jeśli jest w historii.
    """
    global finished
    if finished:
        finished = False
        confirm_button.configure(text="Next", state="normal")

    if questions_history:
        last_q = questions_history.pop()
        system.retract_ost(last_q)
        load_clips_state()

if __name__ == "__main__":
    customtkinter.set_appearance_mode("light")
    customtkinter.set_default_color_theme("green")

    root = customtkinter.CTk()
    system = SystemEkspercki("baza_wiedzy2.clp")

    build_gui(root)
    load_clips_state()

    root.mainloop()
