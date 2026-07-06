export const clerkAppearance = {
  variables: {
    colorPrimary: "#93b7a9",
    colorSuccess: "#6b9e8e",
    colorText: "#0f1a17",
    colorTextSecondary: "#6b8078",
    colorBackground: "#ffffff",
    colorInputBackground: "#ffffff",
    colorInputText: "#0f1a17",
    colorNeutral: "#6b8078",
    borderRadius: "8px",
    fontFamily: "DM Sans, system-ui, sans-serif",
    fontSize: "15px",
  },
  elements: {
    headerTitle: { display: "none" },
    headerSubtitle: { display: "none" },
    card: { boxShadow: "0 4px 24px rgba(0,0,0,.08)", borderRadius: "12px" },
    formButtonPrimary: {
      backgroundColor: "#93b7a9",
      fontWeight: "700",
      "&:hover": { backgroundColor: "#6b9e8e" },
    },
    formFieldInput: {
      borderColor: "#d8e4df",
      "&:focus": { borderColor: "#93b7a9", boxShadow: "0 0 0 2px rgba(147,183,169,.25)" },
    },
    footerActionLink: { color: "#6b9e8e" },
    identityPreviewEditButton: { color: "#6b9e8e" },
    formResendCodeLink: { color: "#6b9e8e" },
    footerAction: { display: "none" },
    userButtonPopoverActionButton: { color: "#0f1a17" },
    userButtonPopoverActionButtonIcon: { color: "#6b9e8e" },
    userButtonPopoverFooter: { display: "none" },
    userButtonPopoverCard: { border: "1px solid #c3d9d2" },
    avatarBox: { border: "2px solid #93b7a9", boxShadow: "none" },
  },
} as const;

export const clerkUserButtonAppearance = {
  variables: {
    colorPrimary: "#93b7a9",
    colorText: "#0f1a17",
    colorNeutral: "#6b8078",
  },
  elements: {
    userButtonPopoverActionButton: { color: "#0f1a17" },
    userButtonPopoverActionButtonIcon: { color: "#6b9e8e" },
    userButtonPopoverFooter: { display: "none" },
    userButtonPopoverCard: { border: "1px solid #c3d9d2" },
    avatarBox: { border: "2px solid #93b7a9", boxShadow: "none" },
    userPreviewMainIdentifier: { color: "#0f1a17" },
    userPreviewSecondaryIdentifier: { color: "#6b8078" },
  },
} as const;
